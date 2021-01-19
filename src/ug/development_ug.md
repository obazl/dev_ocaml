[User Guide](index.md)

# Developing OCaml software with OBazl

Quickstart: the quickest way to get started is to clone and run some of the
[demos](https://github.com/obazl/dev_obazl)

* [Overview](#overview)
* [Prerequisites](#prerequisites)
* [Bazel](#bazel)
* [Setup](#setup)
* [Inspecting the Bazel environment, logs, actions, etc.](#inspection)
  * [bazel info](#bazel_info)
  * [command log](#command_log)
  * [output base](#output_base)
  * [actions](#actions)
* [Working with external repositories](#externals)

## <a name="overview">Overview</a>

Developing software with Bazel is pretty much like developing software
with any other build system: lather, rinse, repeat. You edit your
sources, execute a build command of some kind, run a test driver or
executable to verify results, and repeat.

The major differences are of course related to the build program and
the build engine. Bazel build programs are written in the Starlark
language, and Bazel is also the name of the build engine (of which
there is only one.)

Bazel provides a great deal of information about your build structure,
and it provides fine-grained control over build actions. You can build
any target in your project, and only it and its dependencies will be
built. You can parameterize your builds at any level of granularity.
If you include appropriate test targets, you can modularize your
development even if your source code is not organized in a modular
manner.

Furthermore, Bazel includes powerful query facilities that make it
possible to explore the dependency structures of your code. You can
easily list the dependency chain between two targets, or list the
targets that have a certain parameter, etc. You can generate SVG
graphs showing dependency graphs of your code.

Bazel also makes it easy to develop multiple, mutually-dependent
projects simultaneously. If your main project depends on an external
repository, you can easily configure your build to use a local copy of
the dependency _without altering your build code_. One benefit of this
is that it makes it easy to eliminate embedded git submodules.

## <a name="prerequisites">Prerequisites</a>

* Platform: Linux or MacOS. Both Bazel and OCaml support windows, so
  OBazl may work, but it has not been tested and there are no plans to
  do so. However, it should not be terribly difficult to port it to
  Windows. If you have the time and energy to work on this please
  reach out on the [OBazl Discord
  server](https://discord.gg/PHSAW5DUva) and I will be happy to help.

* Build tools. The OCaml toolchain depends on a C/C++ compiler and
  tools. Normally this will be installed by OPAM.

* [OPAM](https://opam.ocaml.org/) installation. The rules have been used
  with version 2.0.7. Earlier versions may work; if not, please [file
  an issue](https://github.com/obazl/rules_opam/issues).

  * Currently the OBazl rules only support an OPAM toolchain installed on
    the local host outside of Bazel's control; they do not support
    fully hermetic builds, where all build inputs including toolchains
    are exclusively controlled by Bazel. A future version of the OBazl
    rules will automatically download and install the entire OCaml
    toolchain and required packages into a private, Bazel-controlled
    cache.

* An OPAM [switch](https://opam.ocaml.org/doc/Usage.html#opam-switch)
  containing the OCaml compiler and OPAM packages your project needs.

  * Instruction for configuring an OPAM switch is beyond the scope of
    this guide, but here are some common useful commands:

    * `$ opam list` - shows all installed packages
    * `$ opam pin list` - shows all "pinned" packages
    * `$ opam config list` - lists all general configuration settings
    * `$ opam config list ounit2` - lists all configuration settings for package `ounit2`
    * `$ opam var` - same as `opam config list`
    * `$ opam var bin` - print the value of the `bin` var of the current switch
    * `$ opam var ounit2:version` - prints version string of package `ounit2`

  * The OBazl rules depend on [ocamlfind](http://projects.camlcity.org/projects/dl/findlib-1.8.1/doc/ref-html/r17.html), which you must install: `$
    opam install ocamlfind`. `ocamlfind` is an application of
    [findlib](http://projects.camlcity.org/projects/findlib.html),
    which is an OCaml library manager that compliments OPAM; most if
    not all OPAM packages contain a findlib `META` file, which is used
    by `findlib`-based tools, chief of which is `ocamlfind`. If you
    are new to OCaml you will probably find it worthwhile to
    familiarize yourself with `ocamlfind`.  In particular:

    * `$ ocamlfind list` - shows all packages _and subpackages_. `opam list` does not show subpackages.

    * `$ ocamlfind query ...` - analyzes package dependencies; see
      [Dependency analysis of
      packages](http://projects.camlcity.org/projects/dl/findlib-1.8.1/doc/guide-html/c161.html)

  * If you use `emacs`, you probably want to install `merlin`.

  * By default, OBazl will use use whatever packages you have
    installed, at whatever version. For production code where you want
    to pin precise versions, you can direct OBazl to verify your
    switch. See
    [OPAM_Configuration](configuration.md#opamconfig)
    for more information.

* [Tools](tools.md)

* Locally installed libraries. Some OPAM packages depend on locally
  installed resources. For example, package `bignum` depends on
  package `zarith`, which depends on a local installation of `libgmp`.

## <a name="bazel">Bazel</a>

[Installation](https://docs.bazel.build/versions/master/install.html).

>    OBazl recommends using [Bazelisk](https://github.com/bazelbuild/bazelisk) ([Installing Bazel using Bazelisk](https://docs.bazel.build/versions/master/install-bazelisk.html)).

If you use Bazelisk, you can pin the Bazel version by putting file
`.bazelversion` in the root directory of your project, containing the
required version string, e.g. `3.7.0`.

If you are just getting started with Bazel, you should work through one of the [Tutorials](https://docs.bazel.build/versions/master/getting-started.html#tutorials)

To work effectively with OBazl you must master the following material at minimum:

* [Bazel Overview](https://docs.bazel.build/versions/master/bazel-overview.html)
* [Concepts and Terminology](https://docs.bazel.build/versions/master/build-ref.html)
* [Specifying targets to build](https://docs.bazel.build/versions/master/guide.html)

For reference:

* [User Guide](https://docs.bazel.build/versions/master/guide.html)

**WARNING**: a great deal of Bazel documentation is available, but it
  is not always easy to find what you need. If you do find it,
  _bookmark it_! For example, the documentation for `--config` is
  buried at the bottom of [.bazelrc, the Bazel configuration file](https://docs.bazel.build/versions/master/guide.html#bazelrc-the-bazel-configuration-file).

**WARNING2**: the documentation is not always up to date. Bazel is
  very stable, but it is also under very active development so the
  documentation may lag. For example, the documentation frequently
  refers to `BUILD` and `WORKSPACE` files. Those still work, but at
  some point support was added for `BUILD.bazel` and `WORKSPACE.bazel`
  (which is what OBazl recommends).

OBazl deviates from standard Bazel conventions in a few minor ways:

* Rules that build executable binaries are named `*_executable`, not
  `*_binary`: `ocaml_executable`, `ppx_executable`

* Library rules (`ocaml_library` and `ppx_library`) do not build
  "separately compiled modules". Instead they provide a simple
  aggregation mechanism, so that you can depend on a collection of
  resources under a single name. In other words, OBazl takes the term
  "library" to mean "collection of resources"; the resources will
  almost always be OCaml compiled modules, but may include e.g.
  runtime data dependencies.

* Archive rules support OCaml archive files ("separately compiled
  modules"): `ocaml_archive`, `ppx_archive`.

## <a name="setup">Setup</a>

To get the most out of OBazl and Bazel, you need to decide on some
conventions and do a little configuration. See [OBazl
Conventions](conventions.md) for a list.

* shell scripts

## <a name="inspection">Inspecting the Bazel environment, logs, build actions, etc.</a>

### <a name="bazel_info">bazel info</a>

The `bazel info` command will print a dictionary listing the
parameters, file locations, etc. that Bazel uses internally. It
supports a large number of options; run `$ bazel help info` to see them
all; to see just the keys for the dictionary, run `$ bazel help info-keys`.

Most of entries in the dictionary, most of the time, can be safely
ignored; but if you run into trouble, two of them can be helpful with
debugging: `command_log` and `output_base`.

### <a name="command_log">command log</a>

Bazel writes logs to a `command_log` file each time it executes a
command; it overwrites the file. You can discover the location of the
file by running `$ bazel info command_log`. Since the output of this
command will overwrite the log file, you must use an alias or shell
script to enable easy browsing.  See the [aliases](conventions.md#aliases)
recommendation in [OBazl Conventions](conventions.md) for an example.

### <a name="output_base">output base</a>

The `output_base` directory contains a subdirectory, `external`, that
contains the external repositories your project has configured. You
can browse the `BUILD.bazel` files of an external repo, for example,
to verify that you are using the correct target labels.

### <a name="actions">actions</a>

A single build target may generate multiple build _actions_. For
example, if an `ocaml_module` rule is parameterized with a `ppx`
argument, it will generate two actions: one to transform the source
file with the PPX, and one to compile the result. Each action will
have a command line string.

Normally there is no need to pay these actions any mind, but if
something goes wrong with your build it may be useful to see exactly
what a build rule is doing - what the actions are, what commands and
arguments are used to run the actions, and what the inputs and outputs
are. Fortunately this is easy to do. You can use the [action query]()
facility to print all the actions generated by a rule without actually
running the rule (so it does not trigger any compilation). For
example, the following will print all the actions (and much additional
information) generated by the `//foo/bar:baz` target:

```
$ bazel aquery //foo/bar:baz
```

See [Transparency](transparency.md) for more information.

#### <a name="cmd_opts">Compile/link commands</a>

**WARNING**: The current version of OBazl uses
[ocamlfind](http://projects.camlcity.org/projects/dl/findlib-1.8.1/doc/ref-html/r17.html#OCAMLFIND.OCAMLOPT)
to drive the OCaml toolchain.  **The compile/link options for `ocamlfind` are different than those for the compilers `ocamlc` and `ocamlopt`.**

TODO: flesh this out a bit more.

## <a name="externals">Working with external repositories</a>
