[Reference Manual](index.md)

# macros

**WARNING**  beta version - subject to change

----
<a id="#ns_env"></a>

## ns_env

<pre>
ns_env(<a href="#ns_env-name">name</a>, <a href="#ns_env-prefix">prefix</a>, <a href="#ns_env-sep">sep</a>, <a href="#ns_env-aliases">aliases</a>)
</pre>

Expands to instance of rule [ocaml_ns_env](rules_ocaml.md#ocaml_ns_env), which initializes a namespace evaluation environment consisting of a pseudo-namespace prefix string and optionally an ns resolver module.

**PARAMETERS**


| Name  | Description | Default Value |
| ------------- | ------------- | ------------- |
| <a id="ns_env-name"></a>name |  Name of the ns env.   |  <code>"_ns_env"</code> |
| <a id="ns_env-prefix"></a>prefix |  String to use as pseudo-namespace prefix for file renaming. Default (<code>None</code>) means prefix is to be formed from the package path, with '/' replaced by '_'.   |  <code>None</code> |
| <a id="ns_env-sep"></a>sep |  <p align="center"> - </p>   |  <code>"_"</code> |
| <a id="ns_env-aliases"></a>aliases |  <p align="center"> - </p>   |  <code>[]</code> |


