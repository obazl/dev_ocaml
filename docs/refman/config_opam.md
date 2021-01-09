[Reference Manual](index.md)

# opam configuration

**WARNING**  beta version - subject to change

WORKSPACE.bazel:

```
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "obazl_rules_opam",
    remote = "https://github.com/obazl/rules_opam",
    branch = "main",
)

load("@obazl_rules_opam//opam:bootstrap.bzl", opam_configure = "configure")
load("//:opam.bzl", "opam")  # An OpamConfig struct defined by user
switch = opam_configure(opam = opam)
```

**NOTES**

* The [OpamConfig](#opamconfig) struct can be defined in any package.
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
| <a id="OpamConfig-switches"></a>switches |  Dictionary from switch name strings to [OpamSwitch](#opamswitch) structures. Example: <pre><code> PACKAGES = {"bin_prot": ["v0.12.0"], ...}<br><br>opam = OpamConfig(<br><br>    version = "2.0",<br><br>    switches  = {<br><br>        "mina-0.1.0": OpamSwitch(<br><br>            default  = True,<br><br>            compiler = "4.07.1",<br><br>            packages = PACKAGES<br><br>        ),<br><br>        "4.07.1": OpamSwitch(<br><br>            compiler = "4.07.1",<br><br>            packages = PACKAGES<br><br>        ),<br><br>    }<br><br>) </code></pre>    |


<a id="#OpamSwitch"></a>

## Provider: OpamSwitch

<pre>
OpamSwitch(<a href="#OpamSwitch-default">default</a>, <a href="#OpamSwitch-compiler">compiler</a>, <a href="#OpamSwitch-packages">packages</a>)
</pre>

OPAM switch configuration.

Example:

```
OpamSwitch(
    default  = True,
    compiler = "4.07.1",
    packages = {
        "async": ["v0.12.0"],
        "bytes": [],
        "core": ["v0.12.1"],
        "ctypes": ["0.17.1", ["ctypes.foreign", "ctypes.stubs"]],
        "ppx_deriving": ["4.4.1", [
            "ppx_deriving.enum",
            "ppx_deriving.eq",
            "ppx_deriving.show"
        ]],
        "ppx_deriving_yojson": ["3.5.2", ["ppx_deriving_yojson.runtime"]],
        "unix": [],
    }
)
```
    

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OpamSwitch-default"></a>default |  Must be True for exactly one switch configuration. Default: False    |
| <a id="OpamSwitch-compiler"></a>compiler |  OCaml compiler version    |
| <a id="OpamSwitch-packages"></a>packages |  List of <code>&lt;pkg name string&gt;: [&lt;version string&gt;] \| [&lt;version string&gt; [&lt;subpkg names&gt;]]</code>, where:<br><br><pre><code> &lt;pkg name string&gt; := name string used for <code>opam</code> or <code>ocamlfind</code> commands<br><br>&lt;version string&gt;  := version string as printed by <code>opam list</code><br><br>&lt;subpkg names&gt;    := list of subpackage name strings as used by ocamlfind </code></pre> Subpackage name strings have the form &lt;pkg&gt;.&lt;subpkg&gt;, and may be discovered by running <code>ocamlfind list</code>.<br><br>**Exception**: for packages that are distributed with the compiler and   have no version string, use the empty list <code>[]</code>; e.g. <code>"bytes": []</code>.    |


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
| <a id="opam_configure-switch"></a>switch |  name of OPAM switch to use for builds. Must match a switch defined in [OpamConfig](#provider-opamconfig) specified in <code>opam</code> attribute. If omitted, switch configured as <code>default</code> in <code>opam</code> struct is used.   |  <code>None</code> |
| <a id="opam_configure-hermetic"></a>hermetic |  Currently only <code>hermetic=False</code> is supported: the rules use the local opam installation.   |  <code>False</code> |
| <a id="opam_configure-verify"></a>verify |  Verify that 1) switch contains required OPAM packages, and 2) they are pinned to required versions   |  <code>False</code> |
| <a id="opam_configure-install"></a>install |  Install missing OPAM packages   |  <code>False</code> |
| <a id="opam_configure-pin"></a>pin |  Pin OPAM packages to required versions   |  <code>False</code> |
| <a id="opam_configure-force"></a>force |  Force pinning: if installed version does not match required version, remove and install/pin required version   |  <code>False</code> |
| <a id="opam_configure-debug"></a>debug |  enable debugging   |  <code>False</code> |


