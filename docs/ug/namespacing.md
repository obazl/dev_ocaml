[User Guide](index.md)

Namespacing
===========

The Problem
-----------

OCaml supports namespaces *within the language*. But unlike many other
languages that support articulated names like `A.B.C`, it does not map
such "module paths" to filesystem paths.

OCaml uses a flat namespace for module source file names. If you use the
same module file name in different file system locations within a
project you will get a name clash. Every module source file must be
uniquely named.

### Solutions

#### Naming

One way to do it: give your source files names that are unlikely to
clash with source filenames from other projectgs. The easy way to do
this is to decide on a prefix string likely to be unique. That might
start with your project name, or it might replicate the filesystem path
locating your source file, by replacing filesystem separator (usually
'/') with '\_' or some other character.

#### Aliasing

The other way to do it is to use OCaml's aliasing mechanism.

#### Hybrid

The third way is to adopt a hybrid strategy that uses both filename
prefixing and OCaml aliasing. That is the strategy pursued by both Dune
and OBazl.

The "top-level module aliases" facility provides a mechanism that tools
can use to emulate hierarchical filesystem-based namespacing.

Special considerations: `-no-alias-deps`, `-opaque`, and `-linkall`.

OBazl
-----

Terminology:

-   namespace
-   alias/aliasing equation
-   ns module
    -   main ns module
    -   ns resolver module a/k/a resolver
-   submodule
-   pseudo-namespace prefix
-   pseudo-recursion

OBazl namespacing is built on two key mechanisms: renaming and aliasing.
Renaming is an OBazl feature; aliasing is and OCaml feature.

"Namespace module" is the term OBazl uses to refer to modules containing
[type-level module
aliases](https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html),
i.e. statements of the form `module N = P`.

> Dune uses variations on the term "wrapped library" where OBazl uses
> namespacing terminology.

macro: ns-env
-------------

This macro instantiates rule `ocaml_ns_env`, which initializes a
*namespace evaluation environment* or `ns env`. An `ns env` consists of
a pseudo-namespace prefix string and optionally an ns resolver module.

rule: ocaml\_ns\_env
--------------------

Macro: ns

Purpose: determines a namespace prefix for renaming files, and writes a
resolver file mapping raw module names to prefixed module names. Modules
(ocaml\_module rules) depend on this to decide how to rename source
files.

ocaml\_ns\_module
-----------------

ocaml\_module ns attribute
--------------------------

------------------------------------------------------------------------

Troubleshooting
---------------

-   Count your underscores! It's easy to write 'Foo\_Bar\_Baz' when you
    should write 'Foo\_Bar\_\_Baz', in which case you may get an
    'Unbound module' warning.

OBSOLETE docs
-------------

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
