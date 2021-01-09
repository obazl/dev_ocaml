# Configuration

## OPAM configuration

**Example**:

`opam.bzl`:

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

### OPAM package verification and pinning

By default, OPAM package dependencies are not verified. To tell OBazl
to verify them, pass `verify=True` in the `OpamSwitch` struct, or set
the environment variable `OBAZL_OPAM_VERIFY=1`, e.g.

```
$ OBAZL_OPAM_VERIFY=1 bazel build //foo/bar
```

or `$ export OBAZL_OPAM_VERIFY=1`.


Environment variables affecting processing of `opam.bzl`:

* `OPAMSWITCH`: if set to a switch name string, overrides configured
  default switch. The switch name must match one defined in the
  `OpamConfig` struct assigned to the `opam` attribute of `opam.bzl`.

* `OBAZL_OPAM_VERIFY`: if defined, overrides `verify=False`

* `OBAZL_OPAM_PIN`: if defined, overrides `pin=False`

## Example

`opam.bzl`: as above

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
load("//:opam.bzl", "opam")  # configuration struct defined by user
switch = opam_configure(opam = opam)

load("@obazl_rules_ocaml//ocaml:bootstrap.bzl", ocaml_configure = "configure")
ocaml_configure( switch = switch )
```
