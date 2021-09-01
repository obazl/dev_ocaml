# namespaces

* [Overview](#overview)
  * [Problem]()
  * [Solutions]()
    * [Renaming](#renaming)
    * [Aliasing](#aliasing)
    * [Namespacing](#namespacing)
* [Terminology](#terminology)
* [Resolving name clashes](#clashes)
* [Troubleshooting]
  * [Case studies](#cases)

## <a name="overview">Overview<a>

### The Problem

OCaml supports namespaces _within the language_. But unlike many other
languages that support articulated names like `A.B.C`, it does not map
such "module paths" to filesystem paths.

OCaml uses a flat namespace for module source file names. If you use
the same module file name in different file system locations within a
project you will get a name clash. Every module source file must be
uniquely named.

To resolve a path like `A.B`, OCaml will "open" module A and search it
for a definition of module B. There is no built-in mapping to the file
system, so unlike (for example) Java, it will not look for a
definition of B in `a/b.ml`. If B is not defined within the text of
module A, OCaml will throw an "unresolved module" [FIXME: what's the
exact msg?] error.

To get around this OCaml added support for "module aliases" in version
4.02. An aliasing equation looks like this: `module B = C`. If OCaml
encounters such an equation (in module A) when trying to resolve
`A.B`, it will switch to search for module C; furthermore, if it does
not find the definition within the same file (where it found the
aliasing equation), it will search the file system for it. (NB: the
search algorithm is complex, see below for more details).
**IMPORTANT** The search will _not_be restricted to the directory
where the aliasing equation is found; it will search the entire search
path (which may be affected by passing `-I` options on the command
line). If it finds module C, then `A.B` will be resolved to `C` (e.g.
`A.B.x` => `C.x`).

The names used on the left- and right-hand sides of a module aliasing
equation must be legal module names, but there are no further
restrictions. In particular there is no constraint that the RHS name
must be related to the LHS name. So if we have `module B = Foo`, then
references to module B will resolve to module Foo; for example,
`A.B.x` will resolve to `Foo.x` (assuming the equation is in the text
of `a.ml`). This obviously could lead to some confusion. Furthermore,
since the OCaml file system paths play no role in name resolution,
such aliasing does not prevent name clashes. If your code contains a
file named `foo.ml` in more than one place, OCaml will find the first
one it encounters as it searches its search paths.

To address such issues OCaml programmers rely on naming conventions.
The obvious way to avoid name clashes is to settle on a module naming
convention that prevents them, such as prefixing file names with a
pseudo-namespace string; for example instead of `a/foo.ml` and
`b/foo.ml`, we might use `a/a_foo.ml` and `b/b_foo.ml` or something
similar. The problem with this is that we must then refer to such
modules using their complete names, e.g. `A_foo` and `B_foo`. This is
not terribly inconvenient, but it clashes with the dotted syntax used
for module "paths" like `A.B.C.x`. We would rather use `A.foo`,
`B.foo`, etc.

Aliasing gets around this problem. The standard convention is to use
file names that correspond to module paths; for example, if the path
is `A.B`, then:

* module A is defined in `a.ml`
* module B is defined in `A__b.ml`
* module A contains alias equation `module B = A__b`

Now `A.B` will resolve to `A__b.ml`.

(For further details, see [Chapter 8, Type-level module aliases](https://ocaml.org/manual/modulealias.html) of the manual.)

**IMPORTANT** Tools such as [Dune]() and [OBazl]() automate the
generation of aliasing equations and the renaming of source files
needed to make this work. For example in the preceding example, you
would have source file `b.ml`, and the tool would automatically rename
`b.ml` to `A__b.ml`, and would generate file `a.ml` containing the
required aliasing equation. But this is not required; you could
implement the same thing manually, by directly using `A__b.ml` and
writing the aliasing equation in `a.ml`. In fact you can use whatever
names you please, so long as you write the aliasing equations
correctly.

**WARNING** Several things complicate this simple model:

* The top-level module in the path may contain code; e.g. you may have
  something like `A.foo`;
  * in such a case the top-level module need not contain aliasing equations
* A module containing the aliasing equations may contain additional
  code.
* The OCaml 'include' directive may be involved
* Module aliasing may be "chained"; that is, you could have a path
  like `A.B.C.D...`, where `A.B` resolves to `A__b.ml`, which contains
  aliasing equation `module C = B__c.ml`, and so on.

#### search resolution

[Caveat: I'm not 100% certain the following is 100% correct, but it should be close.]

When OCaml needs to find a module, say `C`, it will search for:

* An interface for `C`. This search involves:
  * finding `c.mli`
  * then finding the corresponding `c.cmi`
* An implementation for C - `c.cmx` (native compile) or `c.cma`
  (bytecode compile)

When compiling `c.ml` it will search for an interface as above. If it
finds `c.mli` it will compile it to `c.cmi`; if it does not, it will
automatically generate `c.cmi` from `c.ml`.


### <a name="solutions">The Solutions</a>

#### <a name="naming">Renaming</a>

One way to do it: give your source files names that are unlikely to
clash with source filenames from other projects. The easy way to do
this is to decide on a prefix string likely to be unique. That might
start with your project name, or it might replicate the filesystem
path locating your source file, by replacing filesystem separator
(usually '/') with '_' or some other character.

Another form of renaming supported by OBazl: renaming of the module
names under which implementations are accessible. The module name of a
renamed module file need not be derived from the original file name.

#### <a name="aliasing">Aliasing</a>
The other way to do it is to use OCaml's aliasing mechanism.

#### <a name="namespacing">Namespacing</a>

The third way is to adopt a hybrid strategy that uses both filename
prefixing and OCaml aliasing to implement a form of namespacing. That
is the strategy pursued by both Dune and OBazl.

The "top-level module aliases" facility provides a mechanism that
tools can use to emulate hierarchical filesystem-based namespacing.

Special considerations: `-no-alias-deps`, `-opaque`, and `-linkall`.

## <a name="terminology">Terminology</a>

* namespace
* alias/aliasing equation
* ns module
  * main ns module
  * ns resolver module a/k/a resolver
* submodule
* pseudo-namespace prefix
* pseudo-recursion
* dependencies
  * intramural
  * endogenous
  * exogenous

## <a name="obazl">OBazl namespacing</a>

OBazl namespacing is built on two key mechanisms: renaming and
aliasing. Renaming is an OBazl feature; aliasing is an OCaml feature.

"Namespace module" is the term OBazl uses to refer to modules containing
[type-level module
aliases](https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html),
i.e. statements of the form `module N = P`.

a/k/a "resolver"

>    Dune uses variations on the term "wrapped library" where OBazl uses namespacing terminology.

OBazl rules implementing namespacing:

* ocaml_ns_archive
* ocaml_ns_library
* ppx_ns_archive
* ppx_ns_library

Each of these rules has a `submodules` attribute which contains a list
of the labels of modules to be included in the namespace.

For example, if the name of an `ocaml_ns_library` rule is `foo`, and
it contains submodule `:bar`, then the ns module will be `Foo.cmx`,
and the bar submodule will be renamed to `Foo__Bar.cmx`. To produce
`Foo.cmx`, OBazl will generate `Foo.ml`, containing aliasing equations
like `module Bar = Foo__Bar`.

This approach involves a circularity: in order to generate and compile
`Foo.cmx`, the `ocaml_ns_library` rule must depend on the submodules;
but the submodules must depend on the ns module (`Foo.cmx` in this
case). OBazl can get around this, though, since in fact the ns module
(which we call the "resolver" module, since it is used to resolve
references to submodules) only depends on the module names, not the
compiled modules. This is achieved using the `-no-alias-deps` option.

**WARNING** the following is not very clear; until I find time to
write something better, consult the `*_ns_*` rules in
`@obazl_rules_ocaml//_rules`, the `options_ns_resolver` function in
`@obazl_rules_ocaml//_rules/options.bzl` and the template file
`@obazl_rules_ocaml//_templates/BUILD.ocaml.ns`

That solves half of the problem; the other problem to be resolved is
that each submodule must depend on the resolver module. We solve this
using Bazel _**transition functions**_. The `ocaml_module` rule (and
other rules that may be involved in namespaces, like `ocaml_signature`
and the analogous `ppx_*` rules.) have a hidden dependency on a single
`ocaml_ns_resolver` rule and a `submodules` string list flag. The
`ocaml_ns_resolver` target, in turn, depends on some other label
attributes. The transition functions set these attributes at build
time; in effect, they allow us to give this resolver target "reverse
dependencies": the attributes that control its build are set by
targets that depend on it.  Submodules depend on these two deps, but
since the parameters controlling them are set dynamically, at build
time, the object depended on will be customized for the submodule that
depends on it.

[more specifically: rule `ocaml_module` (for example) has an
`_ns_resolver` attribute whose default value is `@ocaml//ns` (i.e.
`@ocaml//ns:ns`). The latter is a 'label_setting' whose value is [the
label of] an `ocaml_ns_resolver` rule (actually, the sole such rule).
so this institutes a dependency on a resolver whose build params will
be set dynamically using transition functions. the `_ns_submodules`
attribute is a label attr whose default value is
`@ocaml//ns:submodules`, which also gets set dynamically.]


For example, when we build an `ocaml_ns_library` target, the
transition functions will set the value of `_ns_resolver` to the
desired namespace, and `_ns_submodules` to the list of submodules for
the namespace. These settings will be set before bazel proceeds to
build the submodules. When the time comes to build a submodule, Bazel
will see that it depends on the ns resolver, so it will first build
the latter. The build rule for it uses the values set by the
transition functions, so the result is a resolver that depends on the
information needed to make it work to compile the submodule.

[TODO: concrete example]

## <a name="clashes">Resolving name clashes</a>

Alias-based namespacing is not foolproof. Different namespaces can
contain the same module name, in which case you will have different
aliasing equations for the same module name. If you open two such
namespaces at the same time, you will likely run into trouble
resolving references to the module in question.

Fortunately OBazl makes it relatively easy to avoid name clashes even
if you use the same module name in multiple places.

## <a name="cases">Troubleshooting case studies</a>

### Multiple submodules with same name

#### Case A

This situation arose during OBazl development. To develop a tool we
wanted to borrow some code from Dune for parsing Dune files. The Dune
code contains `src/dune_lang/escape.ml` and `src/stdune/escape.ml`
(and their interface files). If both were included in ns libraries
then name clashes could emerge. This is because namespace aliasing
always starts with the original module (file) name. So in this case we
had two namespaces both of whose resolvers contained aliasing equations
for 'Escape'.

The compile for `dune_lang/template.ml`, which depends on `Escape`,
was failing with `Unbound value` for `Escape.escape`. The problem was
not that OCaml could not resolve the reference to `Escape`, but that
it resolved it to `stdune/escape.ml` instead of the intended
`dune_lang/escape.ml`, which does not define `escape`.

The reason was that `template.ml` began with `open Stdune`, so the ns
resolver for that namespace was used to look up `Escape`, yielding a
reference to `stdune/escape.ml`.

But if `template.ml` starts by opening `Stdune`, then how else could a
reference to `Escape` be resolved? This turned out to by my error: I
had included both `escape.ml` files in their respective package
namespace libraries, without bothering to closely inspect the 'main'
ns modules (`stdune/stdune.ml` and `dune_lang/dune_lang.ml`). These
did _not_ include aliasing equations for `Escape`. So the reference to
it within `dune_lang/template.ml` would be resolved without using any
namespace (i.e. aliasign) lookups.

To make this work in OBazl use the following technique:

**WARNING** the following is obsolete (our namespacing strategy has changed)

* Exclude the non-namespaced files from the ns-env. One way to do this is to use the `exclude` parameter of the `glob` function; for example:

```
    ns_env(aliases = glob(["*.ml"], exclude = ["escape.ml"]))
```

* Do not list the non-namespaced module in the `submodules` dictionary of the `ocaml_ns_library` rule.

* Do not use a `prefix` attribute on the `ocaml_module` rule instances used to build the non-namespaced modules.

* If the non-namespaced module depends on a namespaced module, you
  must '-open' the namespace containing the latter. Use the prefix of
  your `ns_env()` as the module name. For example:

```
    opts = ["-open", "Demos_Obazl_Stdune__00_ns_env"]
```

>        Currently this must be done manually, but it will soon be automated.

#### Case B

Same problem involving module `Glob`, found in `src/dune_engine` and `other_libs/dune_glob`.

The error message:

```
File "bazel-out/darwin-fastbuild/bin/obazl/dune_engine/_obazl_/Demos_Obazl_Dune_engine__Predicate_lang.ml", line 1:
Error: The implementation bazel-out/darwin-fastbuild/bin/obazl/dune_engine/_obazl_/Demos_Obazl_Dune_engine__Predicate_lang.ml
       does not match the interface bazel-out/darwin-fastbuild/bin/obazl/dune_engine/_obazl_/Demos_Obazl_Dune_engine__Predicate_lang.cmi:
       ...
       In module Glob:
       Values do not match:
         val of_glob :
           Demos_Obazl_Dune_engine__Glob.t -> (string -> bool) t/2
       is not included in
         val of_glob : Demos_Obazl_Dune_glob__Glob.t -> t/1
       File "bazel-out/darwin-fastbuild/bin/obazl/dune_engine/_obazl_/Demos_Obazl_Dune_engine__Predicate_lang.mli", line 49, characters 2-27:
         Expected declaration
       File "bazel-out/darwin-fastbuild/bin/obazl/dune_engine/_obazl_/Demos_Obazl_Dune_engine__Predicate_lang.ml", line 133, characters 6-13:
         Actual declaration
       File "bazel-out/darwin-fastbuild/bin/obazl/dune_engine/_obazl_/Demos_Obazl_Dune_engine__Predicate_lang.ml", line 116, characters 2-24:
         Definition of type t/1
       File "bazel-out/darwin-fastbuild/bin/obazl/dune_engine/_obazl_/Demos_Obazl_Dune_engine__Predicate_lang.ml", lines 3-8, characters 0-22:
         Definition of type t/2
Target //obazl/dune_engine:_Predicate_lang failed to build
```

In short: the problem arose because of the way OBazl handles
dependencies. It retains transitive deps and strictly preserves
ordering. In this case, the way we listed dependencies resulted in the
insertion of `dune_glob/glob.cmo` between `predicate_lang.mli` and
`dune_engine/glob.cmo`, so it and `predicate_lang.ml` used different
`Glob` modules.

Long story short: sometimes this can happen if a structfile and its
sigfile have different deps. Still not sure what causes this problem,
but the workaround was to move the dep on //obazl/dune_glob from _Glob
to _Glob.cmi.

**B** Same name for ns main module and ns submodule

Demo set035/case03: ocaml_ns_module.name = color, contains submodule:

        "//namespaces/obazl/set030/case01:color": "Color",

Only way around this is to change the main ns name?

----

## Troubleshooting

* Count your underscores!  It's easy to write 'Foo_Bar_Baz' when you should write 'Foo_Bar__Baz', in which case you may get an 'Unbound module' warning.

* If you use a main module, you probably need to exclude it from the ns_env. Otherwise it will be aliased.
 e.g. from dune_glob:

```
ns_env(aliases = glob( ["*.ml"], exclude = ["dune_glob.ml"] ) + ["lexer.mll"])
```

### inconsistent assumptions over interface

```
File "namespaces/obazl/set300/case370/foo-bar/test.ml", line 1:
Error: Files namespaces/obazl/set300/case370/foo-bar/test.cmo
       and bazel-out/darwin-fastbuild/bin/namespaces/obazl/set300/case370/foo-bar/_obazl_/Demos_Namespaces_Obazl_Set300_Case370_Foo_bar__Red.cmo
       make inconsistent assumptions over interface Demos_Namespaces_Obazl_Set300_Case370_Foo_bar__Red
```

## OBSOLETE docs

Example
-------


**NOTES**

-   Our example used the same substring for the name and the ns
    attribute, "foo", but this is not required. The name need not
    correspond to the ns in any way; it just functions as a build target
    identifier. In other words, the `name` attribute names the rule, not
    the namespace.

Example:
[demos/namespaces](https://github.com/obazl/dev_obazl/tree/main/demos/namespaces)

> **WARNING** If your module has both a source file (`foo.ml`) and an
> interface file (`foo.mli`), you must put both of them into the
> namespace. More specifically: both the `ocaml_module` and the
> `ocaml_interface` rules for these files must include the `ns`
> attribute that registers them in the namespace. But the `ocaml_ns`
> rule only needs to list the source files in its `submodules`
> attribute. (A future version will make this less cumbersome.)

Type-Level Module Aliases
-------------------------

OCaml has a sophisticated module system that is partially tied to the
file system.

Each OCaml "compilation unit" determines a module, whose name is the
file name, capitalized and truncated to remove the extension. Thus
`foo.ml` determines module `Foo`.

File names including double underscores, such as `foo__bar.ml`, receive
special treatment. The compiler will treat the double underscore as a
dot, in this case yielding `Foo.bar`.

> \[T\]he compiler uses the following heuristic when printing paths:
> given a path Lib\_\_fooBar, if Lib.FooBar exists and is an alias for
> Lib\_\_fooBar, then the compiler will always display Lib.FooBar
> instead of Lib\_\_fooBar. This way the long Mylib\_\_ names stay
> hidden and all the user sees is the nicer dot names. This is how the
> OCaml standard library is compiled.\" (source:
> https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html)

Translated into English, this bit of indecipherability seems to mean
that, for example. if `lib.ml` contains `module FooBar = Lib__fooBar`,
then `Lib.FooBar` corresponds to `Lib__fooBar`. The documentation does
not explicitly say that references to `Foo.Bar` are translated to
`foo__Bar.ml`, but that is the implication.

WARNING: The information about double underscores seems to be outdated.
Experimentation shows that any string can be used; see
[demos/namespaces/minimal/ns\_sep](https://github.com/obazl/dev_obazl/tree/main/demos/namespaces/minimal/ns_sep)
for examples.

References
----------

-   [8.8 Type-level module
    aliases](https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html)
-   [Better namespaces through module
    aliases](https://blog.janestreet.com/better-namespaces-through-module-aliases)
    (blogpost, 2014)

## obsolete stuff

### rule: ocaml_ns_env

Purpose: determines a namespace prefix for renaming files, and writes
a resolver file mapping raw module names to prefixed module names.
Modules (ocaml_module rules) depend on this to decide how to rename
source files.

#### macro: ns_env

This macro instantiates rule `ocaml_ns_env`, which initializes a
_namespace evaluation environment_ or `ns env`. An `ns env` consists
of a pseudo-namespace prefix string and optionally an ns resolver
module.

### attribute: ns_env

Used by `ocaml_module` and `ocaml_signature` to join a namespace.
