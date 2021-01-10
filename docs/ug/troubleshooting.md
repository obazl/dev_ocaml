troubleshooting
===============

no such target `@opam//pkg:`
----------------------------

This will happen if you depend on an OPAM package but do not list it in
the package list for your switch in `opam.bzl` - see [Packages
manifest](bootstrap.md#packages-manifest) and [OPAM
Dependencies](dependencies_opam.md).

E.g.

    no such target '@opam//pkg:ounit2': target 'ounit2' not declared in package 'pkg' defined by /private/var/tmp/_bazel_gar/07858b33091346eb9c40f9f55369f0e5/external/opam/pkg/BUILD.bazel and referenced by '//rules/ocaml_module:_Test'
