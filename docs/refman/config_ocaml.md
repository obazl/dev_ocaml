# ocaml configuration

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

* Load and configure the `opam` repo before the `ocaml` repo.

----
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


