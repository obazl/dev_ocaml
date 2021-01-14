[User Guide](index.md)

# Namespacing

"Namespace module" is the term OBazl uses to refer to modules
containing module alias statements.

## Example

```
ocaml_ns( name = "foo_ns", ns = "foo", submodules = ["bar.ml", "baz.ml"])
ocaml_module( name = "_Bar", src = "bar.ml", ns = ":foo_ns")
ocaml_module( name = "_Baz", src = "baz.ml", ns = ":foo_ns")

```

This would produce `Foo.cmo`, `Foo__Bar.cmo`, and `Foo__Baz.cmo`. The
first would contain alias statments:

```
module Bar = Foo__Bar
module Baz = Foo__Baz
```

**NOTES**

* Our example used the same substring for the name and the ns
  attribute, "foo", but this is not required. The name need not
  correspond to the ns in any way; it just functions as a build target
  identifier. In other words, the `name` attribute names the rule, not
  the namespace.


## OCaml Modules

OCaml has a sophisticated module system that is partially tied to the file system.

Each OCaml "compilation unit" determines a module, whose name is the
file name, capitalized and truncated to remove the extension.  Thus
`foo.ml` determines module `Foo`.

File names including double underscores, such as `foo__bar.ml`,
receive special treatment.  The compiler will treat the double
underscore as a dot, in this case yielding `Foo.bar`.

> [T]he compiler uses the following heuristic when printing paths: given a path Lib__fooBar, if Lib.FooBar exists and is an alias for Lib__fooBar, then the compiler will always display Lib.FooBar instead of Lib__fooBar. This way the long Mylib__ names stay hidden and all the user sees is the nicer dot names. This is how the OCaml standard library is compiled." (source: https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html)

Translated into English, this bit of indecipherability seems to mean
that, for example. if `lib.ml` contains `module FooBar = Lib__fooBar`, then
`Lib.FooBar` corresponds to `Lib__fooBar`.  The documentation does not
explicitly say that references to `Foo.Bar` are translated to
`foo__Bar.ml`, but that is the implication.

WARNING: The information about double underscores seems to be
outdated.  Experimentation shows that single underscores work as well;
see examples/hello/raw/single.



## References

* [8.8 Type-level module aliases](https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html)
* [Better namespaces through module aliases](https://blog.janestreet.com/better-namespaces-through-module-aliases) (blogpost, 2014)
