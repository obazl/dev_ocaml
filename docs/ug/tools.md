Tools
=====

-   [Bazel tools](#bazel)
-   [OBazl tools](#obazl)
-   [OCaml tools](#ocaml)
-   [Dev tools](#devtools)
-   [MacOS](#macos)

<a name="bazel">Bazel tools</a>
-------------------------------

-   [Buildozer](https://github.com/bazelbuild/buildtools/tree/master/buildozer)
    batch editor
-   [Buildifier](https://github.com/bazelbuild/buildtools/blob/master/buildifier/README.md)
    formatter
-   [Skylib](https://github.com/bazelbuild/bazel-skylib) "library of
    Starlark functions for manipulating collections, file paths, and
    various other data types in the domain of Bazel build rules."

<a name="obazl">OBazl tools</a>
-------------------------------

The following tools are under development:

-   Dune conversion tool
-   Shared PPX executables generator
-   Visibility generator
-   ...etc...

<a name="ocaml">OCaml tools</a>
-------------------------------

The OCaml toolchain comes with a collection of useful
[tools](https://caml.inria.fr/pub/docs/manual-ocaml/index.html#sec286).

To see all of them, list the `bin` directory of your switch, which you
can find by running `$ opam config list` or `$ opam var bin`. So:
`` $ ls `opam var bin` ``.

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
-   [ppx\_cstubs](https://fdopen.github.io/ppx_cstubs/) "ppx\_cstubs is
    a ppx-based preprocessor for stub generation with
    [ctypes](https://github.com/ocamllabs/ocaml-ctypes)."

> **WARNING** OBazl currently does not offer direct support for these
> OCaml tools; that will be added on an as-needed basis. If you need it
> now, please [file an
> issue](https://github.com/obazl/rules_ocaml/issues).

<a name="devtools">Dev tools</a>
--------------------------------

-   Pagers. Common choices are [more, less, and
    most](https://www.slackbook.org/html/file-commands-pagers.html). You
    can also use `vim` as a pager; it ships with a script `less.sh` to
    support this use (usually in `/usr/share/vim/vim81/macros`). You can
    make an alias to keep it available, e.g. add
    `alias vls='/usr/share/vim/vim81/macros/less.sh'` to your
    `~/.bashrc` file.

-   [ripgrep](https://github.com/BurntSushi/ripgrep) A very fast and
    powerful replacement for `grep`

-   [fd](https://github.com/sharkdp/fd) A fast and simple replacement
    for `find`

<a name="macos">MacOS</a>
-------------------------

XCode command line tools (with manpages):

-   **otool** you may need this if you have problems linking to C/C++
    code
-   **install\_name\_tool** "change dynamic shared library install
    names"
