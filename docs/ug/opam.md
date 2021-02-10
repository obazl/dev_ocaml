[User Guide](index.md)

OPAM
====

<a name="dependencies">OPAM Dependencies</a>
--------------------------------------------

OPAM dependencies specified by passing their names via the `deps_opam`
attribute.

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
