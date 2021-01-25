[User Guide](index.md)

Troubleshooting
===============

namespace problems
------------------

    Error: The module String_split is an alias for module Stdune__String_split, which is missing

This can happen if you put .ml sources but not their .mli interfaces
into the namespace. Both need to use the `ns` attribute so that they
will be available.

linking problems
----------------

Use action graph queries to print a complete description of the actions
- inputs, outputs, command line - of any build target. This is very
fast; it does not execute the actions so it will not actually build
anything. See [Querying](querying.md) for more information.

no such target `@opam//pkg:`
----------------------------

This will happen if you depend on an OPAM package but do not list it in
the package list for your switch in `opam.bzl` - see [Packages
manifest](bootstrap.md#packages-manifest) and [OPAM
Dependencies](dependencies_opam.md).

E.g.

    no such target '@opam//pkg:ounit2': target 'ounit2' not declared in package 'pkg' defined by /private/var/tmp/_bazel_gar/07858b33091346eb9c40f9f55369f0e5/external/opam/pkg/BUILD.bazel and referenced by '//rules/ocaml_module:_Test'

invalid label
-------------

It's easy to forget to double the slash in labels with explicit
workspace names, e.g. writing `@foo/bar:baz` instead of `@foo//bar:baz`.
If you do this you will get an error like the following:

     invalid label '@ppx/print:text' in attribute 'ppx_print' in 'ocaml_module' rule: invalid repository name '@ppx/print:text': workspace names may contain only A-Z, a-z, 0-9, '-', '_' and '.'
