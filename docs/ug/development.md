[User Guide](index.md)

Developing OCaml software with OBazl
====================================

Prerequisites
-------------

-   Platform: Linux or MacOS. Both Bazel and OCaml support windows, so
    OBazl may work, but it has not been tested and there are no plans to
    do so. However, it should not be terribly difficult to port it to
    Windows. If you have the time and energy to work on this please
    reach out on the [OBazl Discord
    server](https://discord.gg/PHSAW5DUva) and I will be happy to help.

-   [OPAM](https://opam.ocaml.org/) installation. The rules have been
    used with version 2.0.7. Earlier versions may work; if not, please
    [file an issue](https://github.com/obazl/rules_opam/issues).

    -   Currently the OBazl rules only support a toolchain installed on
        the local host outside of Bazel's control; they do not support
        fully hermetic builds, where all build inputs including
        toolchains are exclusively controlled by Bazel. A future version
        of the OBazl rules will automatically download and install the
        entire OCaml toolchain and required packages into a private,
        Bazel-controlled cache..

-   An OPAM [switch](https://opam.ocaml.org/doc/Usage.html#opam-switch)
    containing the OCaml compiler and OPAM packages your project needs.

    -   By default, OBazl will use use whatever packages you have
        installed, at whatever version. For production code where you
        want to pin precise versions, you can direct OBazl to verify
        your switch. See [OPAM
        Configuration](configuration.md#opamconfig) for more
        information.

-   Locally installed libraries. Some OPAM packages depend on locally
    installed resources. For example, package `bignum` depends on
    package `zarith`, which depends on a local installation of `libgmp`.
