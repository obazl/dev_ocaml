## Rules & Tools

* [obazl_rules_ocaml](https://github.com/obazl/rules_ocaml)
* [obazl_rules_opam](https://github.com/obazl/rules_opam)
* [obazl_tools_bazel](https://github.com/obazl/tools_bazel)

## Docs

* [User Guide](ug/index.md)
* [Reference Manual](refman/index.md)

## Demos

* [dev_obazl](https://github.com/obazl/dev_obazl)

## Deployments

The following packages use branch 'main' of the OBazl rules, which may
have changed. Once OBazl gets to version 1.0.0, they will be pinned; in
the meantime, you may need to edit the `obazl_rules_ocaml` rule in the
workspace files, replacing `branch = "main"` with `tag =
"v0.1.0-beta.1"`.

* [Mina Protocol](https://github.com/MinaProtocol/mina/tree/bazel) - bazel branch

  * This was the prototype project used in developing OBazl. It is a
    fairly complex polyglot project that depends on a substantial
    number of external repositories, including C/C++, Rust, and Go
    libraries. The initial build may take over an hour, depending on
    your hardware.

  * The fetch rules for `obazl_rules_ocaml` etc. are in `WORKSPACE.bzl`.

  * Uses submodules. After cloning, run `$ git checkout bazel && git submodule init && git submodule update --init --recursive`

  * To build the main application: `$ bazel build src/app/cli/src:coda.exe`

The remaining repos should build relatively quickly, with the exception of `orocksdb`. To list all targets:

```$ bazel query //...:*`, or `$ bazel query src//...:*```

* [graphql_ppx](https://github.com/o1-labs/graphql_ppx)
* [ocaml-extlib](https://github.com/MinaProtocol/ocaml-extlib)
* [ocaml-jemalloc](git@github.com:obazl/ocaml-jemalloc.git)
* [ocaml-sodium](https://github.com/minatools/ocaml-sodium)
* [orocksdb](https://github.com/minatools/orocksdb/tree/mina) - mina branch
* [ppx_optcomp](https://github.com/MinaProtocol/ppx_optcomp)
* [ppx_version](https://github.com/o1-labs/ppx_version)
* [snarky](https://github.com/o1-labs/snarky) "an OCaml front-end for writing R1CS SNARKs"

## Support
* Discord: [OBazl](https://discord.gg/PHSAW5DUva)
* Twitter: [@obazldev](https://twitter.com/obazldev)

----

### Acknowledgements

Support for the development of OBazl was provided by a Mina Genesis
Token Grant and the generous assistance of the [Mina](https://minaprotocol.com/) team.
