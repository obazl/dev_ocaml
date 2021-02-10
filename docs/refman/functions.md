[Reference Manual](index.md)

# functions

**WARNING**  beta version - subject to change

----
<a id="#ocaml_configure"></a>

## ocaml_configure

<pre>
ocaml_configure(<a href="#ocaml_configure-opam">opam</a>, <a href="#ocaml_configure-switch">switch</a>, <a href="#ocaml_configure-hermetic">hermetic</a>, <a href="#ocaml_configure-verify">verify</a>, <a href="#ocaml_configure-install">install</a>, <a href="#ocaml_configure-pin">pin</a>, <a href="#ocaml_configure-force">force</a>, <a href="#ocaml_configure-debug">debug</a>, <a href="#ocaml_configure-verbose">verbose</a>)
</pre>

Declares workspaces (repositories) the Ocaml rules depend on.

**PARAMETERS**


| Name  | Description | Default Value |
| ------------- | ------------- | ------------- |
| <a id="ocaml_configure-opam"></a>opam |  an [OpamConfig](#provider-opamconfig) provider   |  <code>None</code> |
| <a id="ocaml_configure-switch"></a>switch |  <p align="center"> - </p>   |  <code>None</code> |
| <a id="ocaml_configure-hermetic"></a>hermetic |  <p align="center"> - </p>   |  <code>False</code> |
| <a id="ocaml_configure-verify"></a>verify |  <p align="center"> - </p>   |  <code>False</code> |
| <a id="ocaml_configure-install"></a>install |  <p align="center"> - </p>   |  <code>False</code> |
| <a id="ocaml_configure-pin"></a>pin |  <p align="center"> - </p>   |  <code>False</code> |
| <a id="ocaml_configure-force"></a>force |  <p align="center"> - </p>   |  <code>False</code> |
| <a id="ocaml_configure-debug"></a>debug |  enable debugging   |  <code>False</code> |
| <a id="ocaml_configure-verbose"></a>verbose |  <p align="center"> - </p>   |  <code>False</code> |


<a id="#opam_configure"></a>

## opam_configure

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
| <a id="opam_configure-switch"></a>switch |  name of OPAM switch to use for builds. Must match a switch defined in [OpamConfig](#provider-opamconfig) specified in <code>opam</code> attribute. If omitted, switch configured as <code>default</code> in <code>opam</code> struct is used.   |  <code>None</code> |
| <a id="opam_configure-hermetic"></a>hermetic |  Currently only <code>hermetic=False</code> is supported: the rules use the local opam installation.   |  <code>False</code> |
| <a id="opam_configure-verify"></a>verify |  Verify that 1) switch contains required OPAM packages, and 2) they are pinned to required versions   |  <code>False</code> |
| <a id="opam_configure-install"></a>install |  Install missing OPAM packages   |  <code>False</code> |
| <a id="opam_configure-pin"></a>pin |  Pin OPAM packages to required versions   |  <code>False</code> |
| <a id="opam_configure-force"></a>force |  Force pinning: if installed version does not match required version, remove and install/pin required version   |  <code>False</code> |
| <a id="opam_configure-debug"></a>debug |  enable debugging   |  <code>False</code> |


