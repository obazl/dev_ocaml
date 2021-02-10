[User Guide](index.md)

# Namespacing

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

### <a name="solutions">The Solutions</a>

#### <a name="naming">Renaming</a>

One way to do it: give your source files names that are unlikely to
clash with source filenames from other projectgs. The easy way to do
this is to decide on a prefix string likely to be unique. That might
start with your project name, or it might replicate the filesystem
path locating your source file, by replacing filesystem separator
(usually '/') with '_' or some other character.

Another form of renaming supported by OBazl: renaming of the module
names underwhich implementations are accessible. The module name of a
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

## <a name="obazl">OBazl</a>

OBazl namespacing is built on two key mechanisms: renaming and
aliasing. Renaming is an OBazl feature; aliasing is and OCaml feature.

"Namespace module" is the term OBazl uses to refer to modules containing
[type-level module
aliases](https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html),
i.e. statements of the form `module N = P`.

>    Dune uses variations on the term "wrapped library" where OBazl uses namespacing terminology.


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


### ocaml_ns_module

### attribute: ns_env

Used by `ocaml_module` and `ocaml_signature` to join a namespace.

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
