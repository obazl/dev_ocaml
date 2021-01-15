[User Guide](index.md)

Configuration
=============

-   [OPAM Configuration](#opamconfig)
    -   [The `OpamConfig` provider](#opamconfig_provider)
    -   [The `configure()` function](#opam_configure)
-   [OCAML Configuration](#ocamlconfig)
    -   [The `configure()` function](#ocaml_configure)
-   [Build Settings](#build_settings)
-   [Config Profiles](#config_profiles)

<a name="opamconfig">OPAM Configuration</a>
-------------------------------------------

### <a name="opamconfig_provider">The OpamConfig Provider</a>

The [OPAM `configure` function](../refman/functions.md#opam_configure)
takes an [OpamConfig](../refman/providers_opam.md#opamconfig) argument
that you must define. [Obazl conventions](conventions.md) place this in
`WORKSPACE.bzl`.

**Sample `OpamConfig`**:

`WORKSPACE.bzl`:

    load("@obazl_rules_opam//opam:providers.bzl", "OpamConfig", "OpamSwitch")
    PACKAGES = {"bin_prot": ["v0.12.0"], ...}
    opam = OpamConfig(
        version = "2.0",
        switches  = {
            "myproj-0.1.0": OpamSwitch(
                default  = True,
                compiler = "4.11.1",
                packages = PACKAGES
            ),
            "4.07.1": OpamSwitch(
                compiler = "4.07.1",
                packages = PACKAGES
            ),
        }
    )

Load this symbol (`opam` here, but you can use any symbol) in
`WORKSPACE.bazel` and pass it to the OPAM configuration function:

    ... (obazl_rules_opam fetched)...
    load("@obazl_rules_opam//opam:bootstrap.bzl", opam_configure = "configure")
    load("//:WORKSPACE.bzl", "opam")  # "opam" = OpamConfig struct defined by user
    switch = opam_configure(opam = opam)

For details see [OpamConfig](../refman/providers_opam.md#opamconfig) and
[OpamSwitch](../refman/providers_opam.md#opamswitch).

### `OpamSwitch` Packages

OPAM package dependencies *must* be listed in the `packages` field of
the `OpamSwitch` structs specified as values of the `switches`
dictionary. See [OpamSwitch](../refman/providers_opam.md#popamswitch)
for details.

Version strings may be omitted if verification is disabled (which is the
default); this may be useful during development, before package versions
are known. For subpackages, the empty string is mandatory:

    "core": [],  ## or: "core": [""],
    "lwt": ["", ["lwt.unix"]]

#### OPAM package verification, installation, and pinning

> **WARNING** This functionality is currently undergoing major
> revisions. For now you should manually install (using
> `opam    install`) your switch and required OPAM packages.

By default, OPAM package dependencies are not verified. To tell OBazl to
verify them, pass `verify=True` in the `OpamSwitch` struct, or set the
environment variable `OBAZL_OPAM_VERIFY=1`, e.g.

    $ OBAZL_OPAM_VERIFY=1 bazel build //foo/bar

or `$ export OBAZL_OPAM_VERIFY=1`.

Environment variables affecting processing of the `OpamConfig` struct in
`WORKSPACE.bzl`:

-   `OPAMSWITCH`: if set to a switch name string, overrides configured
    default switch. The switch name must match one defined in the
    `OpamConfig` struct assigned to the `opam` attribute of
    `WORKSPACE.bzl`.

-   `OBAZL_OPAM_VERIFY`: if defined, overrides `verify=False`

-   `OBAZL_OPAM_PIN`: if defined, overrides `pin=False`

### <a name="opam_configure">The OPAM configure() Function</a>

<a name="ocamlconfig">OCaml Configuration</a>
---------------------------------------------

### <a name="ocaml_configure">The OCaml configure() Function</a>

misc
----

Docs on `--config` are buried in [.bazelrc syntax and
semantics](https://docs.bazel.build/versions/master/guide.html#bazelrc-syntax-and-semantics)
