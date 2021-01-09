Bootstrapping and Configuration
===============================

Bootstrapping Functions
-----------------------

### Fetching repositories

The OBazl convention is to put these in `WORKSPACE.bazel`, but that is a
convention, not a requirement; they can go in any extension file (with
extension `.bzl`).

#### Language Rules

Define one `*_fetch_rules` function for each language; call them from
`WORKSPACE.bazel`.

Example:

`WORKSPACE.bazel`:

    ...
    load("//:WORKSPACE.bzl", "cc_fetch_rules", "ocaml_fetch_rules", "rust_fetch_rules")
    cc_fetch_rules()
    ocaml_fetch_rules()
    rust_fetch_rules()
    ...

`WORKSPACE.bzl`:

    load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository") # buildifier: disable=load
    load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")  # buildifier: disable=load
    load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")  # buildifier: disable=load

    #####################
    def cc_fetch_rules():
        maybe(
            git_repository,
            name = "rules_cc",
            remote = "https://github.com/bazelbuild/rules_cc",
            commit = "b1c40e1de81913a3c40e5948f78719c28152486d",
            shallow_since = "1605101351 -0800"
        )

    ########################
    def ocaml_fetch_rules():
        maybe(
            git_repository,
            name = "obazl_rules_opam",
            remote = "https://github.com/obazl/rules_opam",
            branch = "main",
        )

        maybe(
            git_repository,
            name = "obazl_rules_ocaml",
            remote = "https://github.com/obazl/rules_ocaml",
            branch = "main",
        )

    #######################
    def rust_fetch_rules():

        maybe(
            http_archive,
            name = "io_bazel_rules_rust",
            sha256 = "618cba29165b7a893960de7bc48510b0fb182b21a4286e1d3dbacfef89ace906",
            strip_prefix = "rules_rust-5998baf9016eca24fafbad60e15f4125dd1c5f46",
            urls = [
                # Master branch as of 2020-09-24
                "https://github.com/bazelbuild/rules_rust/archive/5998baf9016eca24fafbad60e15f4125dd1c5f46.tar.gz",
            ],
        )

#### Libraries

Example

    def libsodium_fetch_repo(version):

        maybe(
            http_archive,
            name="libsodium",
            url=versions[version].url,
            sha256=versions[version].sha256,
            strip_prefix = "libsodium-" + version,
            build_file_content = "\n".join([
                "filegroup(name = \"all\",",
                "srcs = glob([\"**\"]),",
                "visibility = [\"//visibility:public\"])",
            ]),
        )
