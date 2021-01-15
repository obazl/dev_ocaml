[User Guide](index.md)

# OBazl Conventions

* `WORKSPACE.bazel`, not `WORKSPACE`

* Use `WORKSPACE.bzl` for extension code needed by `WORKSPACE.bazel`,
  such as `fetch()` functions that [fetch](bootstrap.md#fetch_rules)
  language rules and external repositories.

* `BUILD.bazel`, not `BUILD`

* Use `BUILD.bzl` for extension code needed by `BUILD.bazel`

* Importing external repositories

  * If you import only a small number of repositories, put the
    importing rules (`http_repository`, `git_repository`) in
    `WORKSPACE.bazel`

  * Otherwise, define one or more bootstrapping functions in
    `WORKSPACE.bzl` (note the extension, `.bzl`, not `.bazel`)
    responsible for fetching the repositories. See [Bootstrapping and
    Configuration](bootstrap.md) for an example. Name them
    `<lang>_fetch_rules` (for fetching language support packages) and
    `<lang>_fetch_repos` for library repositories.

* Mixed projects - using Bazel and another build tool (e.g. Dune) in
  parallel

  * If you want to keep Bazel files segregated, create a top-level
    `bzl` directory and keep Bazel extension files etc. there.

* `tools` subdirectory




* Put the following in `.gitignore` `dev` - developers can use this
  * for shell scripts, data files, etc. that should not be under
  * version control `logs` `tmp`



## Naming Conventions

* Repository fetching functions:

  * `<lang>_fetch_rules` - for fetching rules packages
  * `<lang>_fetch_repo`, `<lang>_fetch_repos` - for fetching library
  * repositories alternative: `<lang>_fetch_lib`, `<lang>_fetch_libs`

* primary target names should match package name. E.g. `//foo/bar:bar`

* `ocaml_module` and `ppx_module` targets that are package-internal
  should capitalize the initial character (i.e. should match the OCaml
  module name), with a prefixed underscore. For example,
  `ocaml_module(name="_Foo", src="foo.ml"...)`. Public module targets
  (those used by other packages) should use the same convention
  without the underscore prefix, except for the primary target, whose
  case should match the package name.

* `ocaml_interface` targets should follow the same convention as for
  modules, suffixed by `.cmi`. For example:
  `ocaml_interface(name="_Foo.cmi", src="foo.mli"...)`

* `ocaml_ns` and `ppx_ns` target names should be suffixed by `_ns`.

