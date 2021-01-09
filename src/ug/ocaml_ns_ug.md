[User Guide](index.md)

# ocaml_ns

Here is how to build the example from section [8.8 Top-level module aliases](https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html) of the manual.

```
ocaml_ns( name = "Mylib_ns", ns = "Mylib", submodules = ["a.ml", "b.ml"])
ocaml_module( name = "_A", src = "a.ml", ns = ":Mylib_ns")
ocaml_module( name = "_B", src = "b.ml", ns = ":Mylib_ns")
ocaml_archive( name = "Mylib", deps = [":_A", ":_B"])
)
```

**Commentary**

- Building `:Mylib_ns` would generate `Mylib.ml`, containing

```ocaml
module A = Mylib__A
module B = Mylib__B
```

- The `ocaml_ns` rule automatically adds the `-no-alias-deps` needed
  to compile the generated `Mylib.ml` file.

- The namespace name (`Mylib`) is determined by the `ns` attribute, _not_ the
  `name` attribute. The latter names the rule, the former names the
  namespace.

  - The name of the rule can be any legal name. Use of suffixed `_ns`
    is an OBazl convention.

- The double underscore used to form names like `Mylib__A` is
  determined by the `ns_separator` attribute (not shown), which
  defaults to `__`. You should never need to change this, but you can
  if you want to.

- **IMPORTANT** The submodule dependencies of `ocaml_ns` are _file_
  targets, not _build_ targets.

- The `ns` attribute of the `ocaml_module` rule induces a dependency
  on the namespace module, since the latter is needed to build the
  former. Putting the module target labels in the `submodules`
  attribute of `ocaml-ns` would induce a dependency cycle, which Bazel
  disallows. Hence the need to list source files rather than build
  targets as `ocaml_ns` submodule dependencies.

  - It follows that there is no need to list the `ocaml_ns` target
  (`:Mylib_ns`) in the `deps` attribute of `ocaml_module`. The `ns`
  attribute automatically adds it to the dependency graph.

- The `ocaml_module` rule will:

  - rename (by copying) the source file to namespace it; in this example:
    - `a.ml` -> `Mylib__A.ml`
    - `b.ml` -> `Mylib__B.ml`

  - automatically add the options necessary to compile the generated files:
    - `-no-alias-deps`
    - `-open Mylib`

- The leading underscore in the module names `_A` and `_B` is an OBazl
  convention; you can name them however you like. The leading
  underscore is intended to suggest that these targets are private to
  the containing package. This is only a hint to the reader, leading
  underscores in names have no significance to Bazel.

- The `ocaml_archive` rule will package all three modules in an
  archive file `Mylib.cma`.

  - The archive target depends on the namespace module and all the
    (compiled) submodules; however, since the submodules depend on the
    namespace module, and OBazl automatically includes the entire
    transitive dependency graph of each direct dependency, only the
    submodules need be listed as dependencies of the archive.

  - The namespace module could also be included, but it is not
    necessary since OBazl will add it to the dependency graph
    automatically and ensure that dependencies are correctly ordered.
    In this case, `Mylib.cmo` would be listed before `Mylib_A.cmo` and
    `Mylib_B.cmo`.

## Special case: naming clash

It is not unusual to use the same name for the namespace module and
for one of its submodules. In that case, the name of the generated
namespace module would be suffixed by a double underscore. For example:

```ocaml
ocaml_ns( name = "Foo_ns", ns = "foo", submodules = ["foo.ml", "bar.ml"])
ocaml_module( name = "_Foo", src = "foo.ml", ns = ":Foo_ns")
ocaml_module( name = "_Bar", src = "Bar.ml", ns = ":Foo_ns")
```

In this case, the namespace module would be `foo__.ml`, containing:

```ocaml
module Bar = Foo__Bar
```

and `foo.ml` would be compiled without renaming.