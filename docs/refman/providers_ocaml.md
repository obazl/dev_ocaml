[Reference Manual](index.md)

# ocaml providers
**WARNING** Beta version - subject to change

* [OcamlDepsetProvider](#ocamldepsetprovider)
* [OcamlArchivePayload](#ocamlarchivepayload)
* [OcamlArchiveProvider](#ocamlarchiveprovider)
* [OcamlImportProvider](#ocamlimportprovider)
* [OcamlInterfaceProvider](#ocamlinterfaceprovider)
* [OcamlInterfacePayload](#ocamlinterfacepayload)
* [OcamlLibraryProvider](#ocamllibraryprovider)
* [OcamlModuleProvider](#ocamlmoduleprovider)
* [OcamlModulePayload](#ocamlmodulepayload)
* [OcamlNsModuleProvider](#ocamlnsmoduleprovider)
* [OcamlNsModulePayload](#ocamlnsmodulepayload)

----
<a id="#OcamlArchiveProvider"></a>

## OcamlArchiveProvider

<pre>
OcamlArchiveProvider(<a href="#OcamlArchiveProvider-name">name</a>, <a href="#OcamlArchiveProvider-module">module</a>)
</pre>

OCaml archive provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlArchiveProvider-name"></a>name |  Module name    |
| <a id="OcamlArchiveProvider-module"></a>module |  Module file    |


<a id="#OcamlDepsetProvider"></a>

## OcamlDepsetProvider

<pre>
OcamlDepsetProvider(<a href="#OcamlDepsetProvider-opam">opam</a>, <a href="#OcamlDepsetProvider-nopam">nopam</a>, <a href="#OcamlDepsetProvider-cc_deps">cc_deps</a>, <a href="#OcamlDepsetProvider-cc_linkall">cc_linkall</a>)
</pre>

A Provider struct used by OBazl rules to provide heterogenous dependencies. Not provided by rule.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlDepsetProvider-opam"></a>opam |  depset of OPAM deps (Labels) of target    |
| <a id="OcamlDepsetProvider-nopam"></a>nopam |  depset of non-OPAM deps (Files) of target    |
| <a id="OcamlDepsetProvider-cc_deps"></a>cc_deps |  depset of C/C++ lib deps    |
| <a id="OcamlDepsetProvider-cc_linkall"></a>cc_linkall |  string list of cc libs to link with <code>-force_load</code> (Clang) or <code>-whole-archive</code> (Linux). (Corresponds to <code>alwayslink</code> attribute of cc_library etc., and <code>-linkall</code> option for OCaml.)    |


<a id="#OcamlImportProvider"></a>

## OcamlImportProvider

<pre>
OcamlImportProvider(<a href="#OcamlImportProvider-payload">payload</a>, <a href="#OcamlImportProvider-indirect">indirect</a>)
</pre>

OCaml import provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlImportProvider-payload"></a>payload |  A struct with the following fields:             cmx: .cmx file produced by the target             cma: .cma file produced by the target             cmxa: .cmxa file produced by the target             cmxs: .cmxs file produced by the target    |
| <a id="OcamlImportProvider-indirect"></a>indirect |  A depset of indirect deps.    |


<a id="#OcamlLibraryProvider"></a>

## OcamlLibraryProvider

<pre>
OcamlLibraryProvider(<a href="#OcamlLibraryProvider-payload">payload</a>, <a href="#OcamlLibraryProvider-deps">deps</a>)
</pre>

OCaml library provider. A library is a collection of modules, not to be confused with an archive.

Provided by rule: [ocaml_library](rules_ocaml.md#ocaml_library)
    

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlLibraryProvider-payload"></a>payload |  A struct with the following fields:             library: Name of library             modules : vector of modules in lib    |
| <a id="OcamlLibraryProvider-deps"></a>deps |  A pair of depsets:             opam : direct and transitive opam deps (Labels) of target             nopam: direct and transitive non-opam deps (Files) of target             cclib: c/c++ lib deps    |


<a id="#OcamlModuleProvider"></a>

## OcamlModuleProvider

<pre>
OcamlModuleProvider(<a href="#OcamlModuleProvider-name">name</a>, <a href="#OcamlModuleProvider-module">module</a>)
</pre>

OCaml module provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlModuleProvider-name"></a>name |  Module name    |
| <a id="OcamlModuleProvider-module"></a>module |  Module file    |


<a id="#OcamlNsLibraryProvider"></a>

## OcamlNsLibraryProvider

<pre>
OcamlNsLibraryProvider(<a href="#OcamlNsLibraryProvider-name">name</a>, <a href="#OcamlNsLibraryProvider-module">module</a>)
</pre>

OCaml NS Library provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlNsLibraryProvider-name"></a>name |  Module name    |
| <a id="OcamlNsLibraryProvider-module"></a>module |  Module file    |


<a id="#OcamlSignatureProvider"></a>

## OcamlSignatureProvider

<pre>
OcamlSignatureProvider(<a href="#OcamlSignatureProvider-name">name</a>, <a href="#OcamlSignatureProvider-module">module</a>)
</pre>

OCaml interface provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlSignatureProvider-name"></a>name |  Module name    |
| <a id="OcamlSignatureProvider-module"></a>module |  Module file    |


