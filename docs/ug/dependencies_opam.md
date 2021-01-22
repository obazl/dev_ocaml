[User Guide](index.md)

OPAM Dependencies
=================

<a name="ocaml_deps">OPAM Dependencies</a>
------------------------------------------

OPAM dependencies are in the `@opam//pkg:` namespace/package. Their
target names match their OPAM/ocamlfind names. E.g. `@opam//pkg:core`,
`@opam//pkg:ppxlib`, `@opam//pkg:ppx_deriving.show`, etc.

misc
----

Some OPAM packages depend on libraries installed on the local system:

-   all of the conf-\* libs? e.g. conf-gmp
-   pkg-config is require by something - ctypes?
-   zarith - contains c code and needs libgmp-dev, perl
-   async - ?
-   ctypes etc.
-   something depends on libffi, I forget what. ctypes?
-   perl - needed by zarith
-   etc.
