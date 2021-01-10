OCaml Dependencies
==================

<a name="ocaml_deps">OCaml Dependencies</a>
-------------------------------------------

<a name="ppx_deps">PPX Dependencies</a>
---------------------------------------

### <a name="adjunct_deps">Adjunct Dependencies</a>

Sometimes PPX processing injects dependencies that are needed to compile
the result of a PPX transformation. These are often called "runtime"
dependencies, but OBazl calls them *adjunct dependencies*, since they
are not in fact runtime dependencies. Runtime dependencies of a module
or executable are needed when that module or executable is executed.
These dependencies do not fit that description.
