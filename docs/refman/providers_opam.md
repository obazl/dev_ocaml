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

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OpamConfig-version"></a>version |  OPAM version    |
| <a id="OpamConfig-switches"></a>switches |  Dictionary from switch name strings to [OpamSwitch](#opamswitch) structures. Example: <pre><code> PACKAGES = {"bin_prot": ["v0.12.0"], ...}<br><br>opam = OpamConfig(<br><br>    version = "2.0",<br><br>    switches  = {<br><br>        "mina-0.1.0": OpamSwitch(<br><br>            default  = True,<br><br>            compiler = "4.07.1",<br><br>            packages = PACKAGES<br><br>        ),<br><br>        "4.07.1": OpamSwitch(<br><br>            compiler = "4.07.1",<br><br>            packages = PACKAGES<br><br>        ),<br><br>    }<br><br>) </code></pre>    |


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


