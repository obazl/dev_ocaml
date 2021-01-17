[User Guide](index.md)

# OCaml Dependencies

## <a name="ocaml_deps">OCaml Dependencies</a>


## <a name="ppx_deps">PPX Dependencies</a>


### <a name="adjunct_deps">Adjunct Dependencies</a>

Sometimes PPX processing injects dependencies that are needed to
compile the result of a PPX transformation. These are often called
"runtime" dependencies, but OBazl calls them _adjunct dependencies_,
since they are not in fact runtime dependencies. Runtime dependencies
of a module or executable are needed when that module or executable is
executed. These dependencies do not fit that description.


## Dune

WARNING: dune dependencies are expressed as *libraries*, or
*packages*.  In the latter case they are package-manager entitities.
Bazel deps may be individual modules, libraries, archives, etc. but
they are always build targets, not package-manager entities.

I.e. with dune one says "this build depends on that package", which
really means that it depends on compiled entities contained in the
package.  With bazel one says "this build depends on that built
entity".  That does not always imply something compiled by bazel; in
fact, with OBazl, the targets in the @opam//pkg package produce
command line parameters for using OPAM packages.

But in the case of local or immediate deps, there is an ambiguity.

Example: src/lib/syncable_ledger.  The dunefile lists a library with
name "syncable_ledger". The directory contains a file named
"syncable_ledger.ml".  So if we depend on "syncable_ledger", what is
the dep, exactly?

The problem is that we use (by convention) target label ":foo" for
"foo.ml".  But if the lib name is also "foo" then we want to use
":foo" for the library, not the module.

Option: use ":foo_cm" for individual modules/files.  The disadvantage
of this is in label aesthetics.

Label concepts and aesthetics: the idea is that we treat each pkg as a
conceptual unit, and the directory name as the concept name. So we get
labels like "foo/bar:bar", which abbreviates to "foo/bar".  The
package may have additional targets, e.g. "foo/bar:baz", but the core
concept of the package is captured by the name "foo/bar".

Normally (?) a package will correspond to a library/archive containing
multiple modules.  The tricky bit, with dune, is that the library name
may match a module name.  This requires some renaming and module
aliasing.

Another option: use a naming convention for libs and archives,
e.g. "foo_lib" and "foo_archive".  But this prevents naming as above,
i.e. we would have foo/bar:bar_lib instead of just foo/bar.

Rule of thumb: use same name for directory and for library/archive
target, which should be the concept name. For modules in the
lib/archive (i.e. source files in the dir), use :_Filename (only
visible within the package) or :Filename (if the target is used
outside the package).

WARNING: ocamldep lists deps as module names. It doesn't have any idea
of library or package.

