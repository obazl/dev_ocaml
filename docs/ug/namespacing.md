[User Guide](index.md)

Namespacing
===========

"Namespace module" is the term OBazl uses to refer to modules containing
[type-level module
aliases](https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html),
i.e. statements of the form `module N = P`.

Example
-------

    ocaml_ns( name = "foo_ns", ns = "foo", submodules = ["bar.ml", "baz.ml"])
    ocaml_module( name = "_Bar", src = "bar.ml", ns = ":foo_ns")
    ocaml_module( name = "_Baz", src = "baz.ml", ns = ":foo_ns")

This would produce `Foo.cmo` (a "namespace module"), `Foo__Bar.cmo`, and
`Foo__Baz.cmo` ("submodules" in the namespace). The first would contain
type-level aliases:

    module Bar = Foo__Bar
    module Baz = Foo__Baz

The namespace separator is determined by the attribute `ns_sep` of the
`ocaml_ns` rule; it defaults to double-underscore, `__`, as seen in this
example. It is not affected by target names; the underscore here in
\"\_Bar\" and \"\_Baz\" is completely unrelated. Module names are
determined by the source file name, not the target name. (see [Naming
Conventions](conventions.md#naming-conventions)).

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
