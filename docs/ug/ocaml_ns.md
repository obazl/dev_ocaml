[User Guide](index.md)

ocaml\_ns
=========

Here is how to build the example from section [8.8 Top-level module
aliases](https://caml.inria.fr/pub/docs/manual-ocaml/modulealias.html)
of the manual.

    load("@obazl_rules_ocaml//ocaml:rules.bzl", "ocaml_ns_module", "ocaml_module")
    load("@obazl_rules_ocaml//ocaml:macros.bzl", "ns_env")
    ns_env(prefix="mylib")
    ocaml_ns_module( name = "Mylib", submodules = [":_A", ":_B"])
    ocaml_module( name = "_A", src = "a.ml", ns = ":_ns_env")
    ocaml_module( name = "_B", src = "b.ml", ns = ":_ns_env")
    )

**Commentary**

-   The leading underscore in the module names `_A` and `_B` is an OBazl
    convention; you can name them however you like. The leading
    underscore is intended to suggest that these targets are private to
    the containing package. This is only a hint to the reader, leading
    underscores in names have no significance to Bazel.

-   The `ocaml_archive` rule will package all three modules in an
    archive file `Mylib.cma`.

    -   The archive target depends on the namespace module and all the
        (compiled) submodules; however, since the submodules depend on
        the namespace module, and OBazl automatically includes the
        entire transitive dependency graph of each direct dependency,
        only the submodules need be listed as dependencies of the
        archive.

    -   The namespace module could also be included, but it is not
        necessary since OBazl will add it to the dependency graph
        automatically and ensure that dependencies are correctly
        ordered. In this case, `Mylib.cmo` would be listed before
        `Mylib_A.cmo` and `Mylib_B.cmo`.
