[User Guide](index.md)

# Bootstrapping

* [Bootstrapping OBazl](#bootstrap_obazl)
* [Interop: Bootstrapping Language Rules](#rules)
  * [Fetch](#fetch_rules)
  * [Configure](#config_rules)
* [Bootstrapping Library Repositories](#libraries)

## <a name="bootstrap_obazl">Bootstrapping OBazl Rules</a>

WORKSPACE.bazel:

```
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    urls = [
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
    ],
    sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
)

git_repository(
    name = "obazl_tools_bazel",
    remote = "https://github.com/obazl/tools_bazel",
    branch = "dev",
)
git_repository(
    name = "obazl_rules_opam",
    remote = "https://github.com/obazl/rules_opam",
    branch = "dev",
)
git_repository(
    name = "obazl_rules_ocaml",
    remote = "https://github.com/obazl/rules_ocaml",
    branch = "dev",
)

load("@obazl_rules_opam//opam:bootstrap.bzl", opam_configure = "configure")
load("//:WORKSPACE.bzl", "opam") # user-defined OpamConfig struct
switch = opam_configure(opam = opam)

load("@obazl_rules_ocaml//ocaml:bootstrap.bzl", ocaml_configure = "configure")
ocaml_configure( switch = switch )
```

>    **IMPORTANT**: The [OPAM `configure` function](../refman/functions.md#opam_config)
>    takes an `OpamConfig` provider struct that you must define, as well as some other flags;
>    see [OPAM Configuration](configuration.md#opamconfig) for details.

Replace `branch = "dev"` as desired (see [git_repository](https://docs.bazel.build/versions/master/repo/git.html).

If your `WORKSPACE.bazel` gets crowded (as may happen if your project
depends on a lot of external repositories), you may want to wrap the
repository rules in a `fetch()` function and put it in an _extension
file_ (a file with extension `.bzl`). The [OBazl
convention](conventions.md) is to put such extension functions in
`WORKSPACE.bzl`.

## <a name="rules">Bootstrapping Language Rules</a>

### <a name="fetch_rules">Fetching Rules Repositories</a>

The [OBazl convention](conventions.md) is to put fetch code in
`WORKSPACE.bzl`, but that is a convention, not a requirement; they can
go in any extension file (with extension `.bzl`).

Define one `*_fetch_rules` function for each language, and call them
from `WORKSPACE.bazel`.

Example:

WORKSPACE.bzl:

```
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
        branch = "dev",
    )

    maybe(
        git_repository,
        name = "obazl_rules_ocaml",
        remote = "https://github.com/obazl/rules_ocaml",
        branch = "dev",
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
```

```

WORKSPACE.bazel:
...
load("//:WORKSPACE.bzl", "cc_fetch_rules", "ocaml_fetch_rules", "rust_fetch_rules")
cc_fetch_rules()
ocaml_fetch_rules()
rust_fetch_rules()
...
## load and run config functions for language rules...
...
```

>    You must [fetch](#fetch_rules) and [configure `obazl_rules_opam`](configuration.md#opamconfig)
>    before you [configure `obazl_rules_ocaml`](configuration.md#ocamlconfig).

### <a name="config_rules">Configuring Language Rules</a>

Most Language Support Packages (LSPs) contain one or more
configuration functions. These must be loaded and executed after the
rules are fetched.  See the LSP documentation for details.

Currently the `obazl_rules_ocaml` LSP depends on `obazl_rules_opam`, since
OPAM is widely acknowledged as the standard OCaml package manager and
most projects are likely to use it. A future version will decouple the
OCaml rules from the OPAM rules. If your OCaml project does not use
OPAM, and the OBazl rules do not meet your needs, please [file an
issue](https://github.com/obazl/rules_ocaml/issues).

See the Reference Manual [Functions](../refman/index.md#functions) section for details.

## <a name="libraries">Bootstrapping Library Repositories</a>

Example

```
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
```
