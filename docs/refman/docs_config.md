# configuration

**WARNING**  beta version - subject to change

WORKSPACE.bazel:

```
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

**NOTES**

* The opam configuration struct can be defined in any package.
* Load and configure the `opam` repo before the `ocaml` repo.

----
<a id="#OpamConfig"></a>

## Provider: OpamConfig

<pre>
OpamConfig(<a href="#OpamConfig-version">version</a>, <a href="#OpamConfig-switches">switches</a>)
</pre>

OPAM configuration structure.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OpamConfig-version"></a>version |  OPAM version    |
| <a id="OpamConfig-switches"></a>switches |  OpamSwitch structure    |


<a id="#OpamSwitch"></a>

## Provider: OpamSwitch

<pre>
OpamSwitch(<a href="#OpamSwitch-default">default</a>, <a href="#OpamSwitch-compiler">compiler</a>, <a href="#OpamSwitch-packages">packages</a>)
</pre>

OPAM switch configuration.

    Package specification format (by example):

    - `"alcotest": ["1.1.0"]`
    - `"ppx_deriving_yojson": ["3.5.2", ["ppx_deriving_yojson.runtime"]]`
    - `"ppx_deriving": ["4.4.1", ["ppx_deriving.api", "ppx_deriving.enum"]]`
    - `"async_kernel": ["v0.12.0", "src/external/async_kernel"]` # pin pkg to path

    

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OpamSwitch-default"></a>default |  Must be True for exactly one switch configuration. Default: False    |
| <a id="OpamSwitch-compiler"></a>compiler |  OCaml compiler version    |
| <a id="OpamSwitch-packages"></a>packages |  Dict of required OPAM packages. Keys: package name strings. Values: package spec.    |


<a id="#ocaml_configure"></a>

## Function: ocaml_configure

<pre>
ocaml_configure(<a href="#ocaml_configure-debug">debug</a>, <a href="#ocaml_configure-switch">switch</a>)
</pre>

Declares workspaces (repositories) the Ocaml rules depend on.

**PARAMETERS**


| Name  | Description | Default Value |
| ------------- | ------------- | ------------- |
| <a id="ocaml_configure-debug"></a>debug |  enable debugging   |  <code>False</code> |
| <a id="ocaml_configure-switch"></a>switch |  name of OPAM switch to use for builds   |  <code>None</code> |


<a id="#opam_configure"></a>

## Function: opam_configure

<pre>
opam_configure(<a href="#opam_configure-opam">opam</a>, <a href="#opam_configure-switch">switch</a>, <a href="#opam_configure-hermetic">hermetic</a>, <a href="#opam_configure-verify">verify</a>, <a href="#opam_configure-install">install</a>, <a href="#opam_configure-pin">pin</a>, <a href="#opam_configure-force">force</a>, <a href="#opam_configure-debug">debug</a>)
</pre>

Bootstraps and configures OPAM switch and workspaces needed for OPAM support. Returns: configured switch name (string).

**WARNING** Support for verify/pin/install is not yet fully implemented. Currently verification implies `install=True` and `pin=True`.  Verification with `install=False` and/or `pin=False`, when implemented, will instead emit warnings for missing or misconfigured packages.

Env vars:

  - OPAMSWITCH: if defined, overrides `switch` attribute and configured default switch
  - OBAZL_OPAM_VERIFY: if defined, overrides `verify=False`
  - OBAZL_OPAM_PIN: if defined, overrides `pin=False`


**PARAMETERS**


| Name  | Description | Default Value |
| ------------- | ------------- | ------------- |
| <a id="opam_configure-opam"></a>opam |  an [OpamConfig](#provider-opamconfig) provider   |  <code>None</code> |
| <a id="opam_configure-switch"></a>switch |  name of OPAM switch to use for builds. Must match a switch defined in <code>opam</code> config struct. If omitted, switch configured as <code>default</code> in <code>opam</code> struct is used.   |  <code>None</code> |
| <a id="opam_configure-hermetic"></a>hermetic |  Currently only <code>hermetic=False</code> is supported: the rules use the local opam installation.   |  <code>False</code> |
| <a id="opam_configure-verify"></a>verify |  Verify that 1) switch contains required OPAM packages, and 2) they are pinned to required versions   |  <code>False</code> |
| <a id="opam_configure-install"></a>install |  Install missing OPAM packages   |  <code>False</code> |
| <a id="opam_configure-pin"></a>pin |  Pin OPAM packages to required versions   |  <code>False</code> |
| <a id="opam_configure-force"></a>force |  Force pinning: if installed version does not match required version, remove and install/pin required version   |  <code>False</code> |
| <a id="opam_configure-debug"></a>debug |  enable debugging   |  <code>False</code> |


