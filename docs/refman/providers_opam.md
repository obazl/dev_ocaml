[Reference Manual](index.md)

# opam providers

**WARNING**  beta version - subject to change

* [OpamPkgInfo](#opampkginfo)

The following Providers are used as structs, to configure the rules;
they are not delivered as the output of any rules.

* [OpamConfig](#opamconfig)
* [OpamSwitch](#opamswitch)

----
<a id="#OpamConfig"></a>

## OpamConfig

<pre>
OpamConfig(<a href="#OpamConfig-version">version</a>, <a href="#OpamConfig-switches">switches</a>)
</pre>

OPAM configuration structure.

Example:

```
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


**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OpamConfig-version"></a>version |  OPAM version    |
| <a id="OpamConfig-switches"></a>switches |  Dictionary from switch name strings to [OpamSwitch](#opamswitch) provider structs.    |


<a id="#OpamPkgInfo"></a>

## OpamPkgInfo

<pre>
OpamPkgInfo(<a href="#OpamPkgInfo-pkg">pkg</a>, <a href="#OpamPkgInfo-ppx_driver">ppx_driver</a>)
</pre>

Provider for OPAM packages.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OpamPkgInfo-pkg"></a>pkg |  Label depset containing package name string used by ocamlfind.    |
| <a id="OpamPkgInfo-ppx_driver"></a>ppx_driver |  True if ocamlfind would generate -ppx command line arg when this lib is listed as a dep.    |


<a id="#OpamSwitch"></a>

## OpamSwitch

<pre>
OpamSwitch(<a href="#OpamSwitch-default">default</a>, <a href="#OpamSwitch-compiler">compiler</a>, <a href="#OpamSwitch-packages">packages</a>)
</pre>

OPAM switch configuration.

The `packages` parameter maps package names to package specifictions.
All package dependencies must be listed. Package specification
grammar:

```
      [<version>]
    | [<version>, [<subpkg> {, <subpkg>}*]]
    | [<version>, <path>]
    | [<version>, <url>]

where:
<versionstring>  := version string as printed by `opam list`
<subpkg>         := subpackage name string as listed by `ocamlfind list`
<path>           := string, path to implementation code
<url>            := HTTPS URL of implementation code
```

Package and subpackage names must match the name listed by `opam list`
or `ocamlfind list`. Some packages are listed by `ocamlfind list`, but
not by `opam list`.  Subpackages are listed only by `ocamlfind list`.

**Version strings**: for packages that are distributed with the
compiler and have no version string, use the empty list `[]` for the
version string; e.g. `"bytes": []`. To allow any version, use the
empty list or the empty string (required if there is a subpackage).  E.g.

```
        "lwt": ["", ["lwt.unix"]]
```

**Example**:

```
OpamSwitch(
    default  = True,
    compiler = "4.07.1",
    packages = {
        "async": ["v0.12.0"],
        "bytes": [], # not listed by `opam`; `ocamlfind` reports "distributed with OCaml"
        "core": ["v0.12.1"],
        "ctypes": ["0.17.1", ["ctypes.foreign", "ctypes.stubs"]],
        "ppx_deriving": ["4.4.1", [
            "ppx_deriving.eq",
            "ppx_deriving.show"
        ]],
        "ppx_deriving_yojson": ["3.5.2", ["ppx_deriving_yojson.runtime"]],
    }
)
```
    

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OpamSwitch-default"></a>default |  Must be True for exactly one switch configuration. Default: False    |
| <a id="OpamSwitch-compiler"></a>compiler |  OCaml compiler version    |
| <a id="OpamSwitch-packages"></a>packages |  Dictionary mapping package names to package specs.    |


