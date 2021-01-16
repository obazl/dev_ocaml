[User Guide](index.md)

Developing OCaml software with OBazl
====================================

-   [Prerequisites](#prerequisites)
-   [OCaml Tools](#ocaml_tools)
-   [Setup](#setup)
-   [Inspecting build actions and commands](#inspection)
-   [Working with external repositories](#externals)

<a name="prerequisites">Prerequisites</a>
-----------------------------------------

-   Platform: Linux or MacOS. Both Bazel and OCaml support windows, so
    OBazl may work, but it has not been tested and there are no plans to
    do so. However, it should not be terribly difficult to port it to
    Windows. If you have the time and energy to work on this please
    reach out on the [OBazl Discord
    server](https://discord.gg/PHSAW5DUva) and I will be happy to help.

-   Build tools. The OCaml toolchain depends on a C/C++ compiler and
    tools.

-   File/text tools. Developing with Bazel from the command line may
    involve lots of searching and browsing, even if you use an IDE. Some
    useful but optional tools:

    -   A good pager. Common choices are [more, less, and
        most](https://www.slackbook.org/html/file-commands-pagers.html).
        You can also use `vim` as a pager; it ships with a script
        `less.sh` to support this use (usually in
        `/usr/share/vim/vim81/macros`). You can make an alias to keep it
        available, e.g. add
        `alias vls='/usr/share/vim/vim81/macros/less.sh'` to your
        `~/.bashrc` file.

    -   [ripgrep](https://github.com/BurntSushi/ripgrep) A very fast and
        powerful replacement for `grep`
    -   [fd](https://github.com/sharkdp/fd) A fast and simple
        replacement for `find`

-   [OPAM](https://opam.ocaml.org/) installation. The rules have been
    used with version 2.0.7. Earlier versions may work; if not, please
    [file an issue](https://github.com/obazl/rules_opam/issues).

    -   Currently the OBazl rules only support a toolchain installed on
        the local host outside of Bazel's control; they do not support
        fully hermetic builds, where all build inputs including
        toolchains are exclusively controlled by Bazel. A future version
        of the OBazl rules will automatically download and install the
        entire OCaml toolchain and required packages into a private,
        Bazel-controlled cache.

-   An OPAM [switch](https://opam.ocaml.org/doc/Usage.html#opam-switch)
    containing the OCaml compiler and OPAM packages your project needs.

    -   Instruction for configuring an OPAM switch is beyond the scope
        of this guide, but here are some common useful commands:

        -   `$ opam list` - shows all installed packages
        -   `$ opam pin list` - shows all "pinned" packages
        -   `$ opam config list` - lists all general configuration
            settings
        -   `$ opam config list ounit2` - lists all configuration
            settings for package `ounit2`

    -   The OBazl rules depend on `ocamlfind`, which you must install:
        `$ opam install ocamlfind`. `ocamlfind` is an application of
        [findlib](http://projects.camlcity.org/projects/findlib.html),
        which is an OCaml library manager that compliments OPAM; most if
        not all OPAM packages contain a findlib `META` file, which is
        used by `findlib`-based tools, chief of which is `ocamlfind`. If
        you are new to OCaml you will probably find it worthwhile to
        familiarize yourself with `ocamlfind`. In particular:

        -   `$ ocamlfind list` - shows all packages *and subpackages*.
            `opam list` does not show subpackages.

        -   `$ ocamlfind query ...` - analyzes package dependencies; see
            [Dependency analysis of
            packages](http://projects.camlcity.org/projects/dl/findlib-1.8.1/doc/guide-html/c161.html)

    -   If you use `emacs`, you probably want to install `merlin`.

    -   By default, OBazl will use use whatever packages you have
        installed, at whatever version. For production code where you
        want to pin precise versions, you can direct OBazl to verify
        your switch. See
        [OPAM\_Configuration](configuration.md#opamconfig) for more
        information.

-   Locally installed libraries. Some OPAM packages depend on locally
    installed resources. For example, package `bignum` depends on
    package `zarith`, which depends on a local installation of `libgmp`.

<a name="ocaml_tools">OCaml Tools</a>
-------------------------------------

The OCaml toolchain comes with a collection of useful
[tools](https://caml.inria.fr/pub/docs/manual-ocaml/index.html#sec286).

To see all of them, list the `bin` directory of your switch, which you
can find by running `$ opam config list`.

These will probably be useful for Obazl development:

-   [ocamldep](https://caml.inria.fr/pub/docs/manual-ocaml/depend.html) -
    given a list of source files, prints information about their
    dependencies. Since Bazel requires that all build dependencies be
    explicitly enumerated, this can be a very useful tool.
-   `ocamlobjinfo` - shows the internal structure of compiled modules,
    interfaces, and archives. You can use this to verify that your build
    outputs are as expected.

Third-party tools:

-   [codept](https://github.com/Octachron/codept) "Codept intends to be
    a dependency solver for OCaml projects and an alternative to
    ocamldep."
-   [cppo](https://github.com/ocaml-community/cppo) "Cppo is an
    equivalent of the C preprocessor for OCaml programs."

<a name="setup">Setup</a>
-------------------------

<a name="inspection">Inspecting build actions and commands</a>
--------------------------------------------------------------

A single build target may generate multiple build *actions*. For
example, if an `ocaml_module` rule is parameterized with a `ppx`
argument, it will generate two actions: one to transform the source file
with the PPX, and one to compile the result. Each action will have a
command line string.

Normally there is no need to pay these actions any mind, but if
something goes wrong with your build it may be useful to see exactly
what a build rule is doing - what the actions are, what commands and
arguments are used to run the actions, and what the inputs and outputs
are. Fortunately this is easy to do. You can use the [action query]()
facility to print all the actions generated by a rule without actually
running the rule (so it does not trigger any compilation). For example,
the following will print all the actions (and much additional
information) generated by the `//foo/bar:baz` target:

    $ bazel aquery //foo/bar:baz

See [Transparency](transparency.md) for more information.

<a name="externals">Working with external repositories</a>
----------------------------------------------------------
