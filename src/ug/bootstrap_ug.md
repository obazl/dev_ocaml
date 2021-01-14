[User Guide](index.md)

# Bootstrapping and Configuring External Repositories

* [Bootstrapping the Rules](#rules)
  * [Configuring the Rules](#configuration)
* [Bootstrapping Library Repositories](#libraries)

## <a name="rules">Bootstrapping the Rules</a>

### Fetching Rules Repositories

The OBazl convention is to put these in `WORKSPACE.bazel`, but that is
a convention, not a requirement; they can go in any extension file
(with extension `.bzl`).

#### Language Rules

Define one `*_fetch_rules` function for each language; call them from `WORKSPACE.bazel`.

Example:

`WORKSPACE.bazel`:
```
...
load("//:WORKSPACE.bzl", "cc_fetch_rules", "ocaml_fetch_rules", "rust_fetch_rules")
cc_fetch_rules()
ocaml_fetch_rules()
rust_fetch_rules()
...
```

`WORKSPACE.bzl`:
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
```

## <a name="configuration">Configuring the Rules</a>

### OPAM configuration

**Example**:

`WORKSPACE.bzl`:

```
load("@obazl_rules_opam//opam:providers.bzl", "OpamConfig", "OpamSwitch")
PACKAGES = {"bin_prot": ["v0.12.0"], ...}
opam = OpamConfig(
    version = "2.0",
    switches  = {
        "mina-0.1.0": OpamSwitch(
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
```

For details see [OpamConfig](../refman/config_opam.md#provider-opamconfig) and [OpamSwitch](../refman/config_opam.md#provider-opamswitch).

### Packages manifest

OPAM package dependencies _must_ be listed in the `packages` field of
the `OpamSwitch` structs specified as values of the `switches`
dictionary. See
[OpamSwitch](../refman/config_opam.md#provider-opamswitch) for the
syntax.

Version strings may be omitted if verification is disabled (which is
the default); this may be useful during development, before package
versions are known. For subpackages, the empty string is mandatory:

```
"core": [],  ## or: "core": [""],
"lwt": ["", ["lwt.unix"]]
```

#### OPAM package verification and pinning

By default, OPAM package dependencies are not verified. To tell OBazl
to verify them, pass `verify=True` in the `OpamSwitch` struct, or set
the environment variable `OBAZL_OPAM_VERIFY=1`, e.g.

```
$ OBAZL_OPAM_VERIFY=1 bazel build //foo/bar
```

or `$ export OBAZL_OPAM_VERIFY=1`.


Environment variables affecting processing of the `OpamConfig` struct in `WORKSPACE.bzl`:

* `OPAMSWITCH`: if set to a switch name string, overrides configured
  default switch. The switch name must match one defined in the
  `OpamConfig` struct assigned to the `opam` attribute of `WORKSPACE.bzl`.

* `OBAZL_OPAM_VERIFY`: if defined, overrides `verify=False`

* `OBAZL_OPAM_PIN`: if defined, overrides `pin=False`

## Example

`WORKSPACE.bzl`: as above

WORKSPACE.bazel:

```
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
load("//:WORKSPACE.bzl", "opam")  # configuration struct defined by user
switch = opam_configure(opam = opam)

load("@obazl_rules_ocaml//ocaml:bootstrap.bzl", ocaml_configure = "configure")
ocaml_configure( switch = switch )
```

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
