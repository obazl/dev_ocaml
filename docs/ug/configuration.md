Configuration
=============

`opam.bzl`:

    load("@obazl_rules_opam//opam:providers.bzl", "OpamConfig", "OpamSwitch")

    PACKAGES = {
        "bin_prot": ["v0.12.0"],
        ... etc. ...
    }

    opam = OpamConfig(
        version = "2.0",
        switches  = {
            "dev-0.1.0": OpamSwitch(
                default  = True,
                compiler = "4.07.1",
                packages = PACKAGES
            ),
            "4.07.1": OpamSwitch(
                compiler = "4.07.1",
                packages = PACKAGES
            ),
        }
    )

WORKSPACE.bazel:

    load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

    git_repository(
        name = "obazl_tools_bazel",
        remote = "https://github.com/obazl/tools_bazel",
        branch = "main",
    )
    git_repository(
        name = "obazl_rules_opam",
        remote = "https://github.com/obazl/rules_opam",
        branch = "main",
    )
    git_repository(
        name = "obazl_rules_ocaml",
        remote = "https://github.com/obazl/rules_ocaml",
        branch = "main",
    )

    load("@obazl_rules_opam//opam:bootstrap.bzl", opam_configure = "configure")
    load("//:opam.bzl", "opam")  # configuration struct defined by user
    switch = opam_configure(opam = opam)

    load("@obazl_rules_ocaml//ocaml:bootstrap.bzl", ocaml_configure = "configure")
    ocaml_configure( switch = switch )
