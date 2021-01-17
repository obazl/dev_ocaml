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
<a id="#OcamlArchivePayload"></a>

## OcamlArchivePayload

<pre>
OcamlArchivePayload(<a href="#OcamlArchivePayload-archive">archive</a>, <a href="#OcamlArchivePayload-cma">cma</a>, <a href="#OcamlArchivePayload-cmxa">cmxa</a>, <a href="#OcamlArchivePayload-a">a</a>)
</pre>

A Provider struct used by [OcamlArchiveProvider](#ocamlarchiveprovider) and [PpxArchiveProvider](providers_ppx.md#ppxarchiveprovider). Not directly provided by any rule.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlArchivePayload-archive"></a>archive |  Name of archive    |
| <a id="OcamlArchivePayload-cma"></a>cma |  .cma file produced by the target (bytecode mode)    |
| <a id="OcamlArchivePayload-cmxa"></a>cmxa |  .cmxa file produced by the target (native mode)    |
| <a id="OcamlArchivePayload-a"></a>a |  .a file produced by the target (native mode)    |


<a id="#OcamlArchiveProvider"></a>

## OcamlArchiveProvider

<pre>
OcamlArchiveProvider(<a href="#OcamlArchiveProvider-payload">payload</a>, <a href="#OcamlArchiveProvider-deps">deps</a>)
</pre>

OCaml archive provider.

Provided by rule: [ocaml_archive](rules_ocaml.md#ocaml_archive)
    

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlArchiveProvider-payload"></a>payload |  An [OcamlArchivePayload](#ocamlarchivepayload) provider    |
| <a id="OcamlArchiveProvider-deps"></a>deps |  An [OcamlDepsetProvider](#ocamldepsetprovider) provider.    |


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


<a id="#OcamlInterfacePayload"></a>

## OcamlInterfacePayload

<pre>
OcamlInterfacePayload(<a href="#OcamlInterfacePayload-cmi">cmi</a>, <a href="#OcamlInterfacePayload-mli">mli</a>)
</pre>

OCaml interface payload.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlInterfacePayload-cmi"></a>cmi |  .cmi file produced by the target    |
| <a id="OcamlInterfacePayload-mli"></a>mli |  .mli source file. without the source file, the cmi file will be ignored!    |


<a id="#OcamlInterfaceProvider"></a>

## OcamlInterfaceProvider

<pre>
OcamlInterfaceProvider(<a href="#OcamlInterfaceProvider-payload">payload</a>, <a href="#OcamlInterfaceProvider-deps">deps</a>)
</pre>

OCaml interface provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlInterfaceProvider-payload"></a>payload |  An [OcamlInterfacePayload](#ocamlinterfacepayload) structure.    |
| <a id="OcamlInterfaceProvider-deps"></a>deps |  An [OcamlDepsetProvider](#ocamldepsetprovider).    |


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


<a id="#OcamlModulePayload"></a>

## OcamlModulePayload

<pre>
OcamlModulePayload(<a href="#OcamlModulePayload-cmx">cmx</a>, <a href="#OcamlModulePayload-o">o</a>, <a href="#OcamlModulePayload-cmo">cmo</a>, <a href="#OcamlModulePayload-cmi">cmi</a>, <a href="#OcamlModulePayload-mli">mli</a>, <a href="#OcamlModulePayload-cmt">cmt</a>)
</pre>

OCaml module payload.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlModulePayload-cmx"></a>cmx |  .cmx file produced from the target (native mode)    |
| <a id="OcamlModulePayload-o"></a>o |  .o file produced from the target (native mode)    |
| <a id="OcamlModulePayload-cmo"></a>cmo |  .cmo file produced from the target (bytecode mode)    |
| <a id="OcamlModulePayload-cmi"></a>cmi |  .cmi file. Passed through from <code>intf</code> attrib if present, otherwise generated from <code>src</code>.    |
| <a id="OcamlModulePayload-mli"></a>mli |  .mli source file passed through from <code>intf</code> attrib if present, otherwise None    |
| <a id="OcamlModulePayload-cmt"></a>cmt |  .cmt file produced from the target (optional)    |


<a id="#OcamlModuleProvider"></a>

## OcamlModuleProvider

<pre>
OcamlModuleProvider(<a href="#OcamlModuleProvider-payload">payload</a>, <a href="#OcamlModuleProvider-deps">deps</a>)
</pre>

OCaml module provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlModuleProvider-payload"></a>payload |  An [OcamlModulePayload](#ocamlmodulepayload) provider.    |
| <a id="OcamlModuleProvider-deps"></a>deps |  An [OcamlDepsetProvider](#ocamldepsetprovider) provider.    |


<a id="#OcamlNsModulePayload"></a>

## OcamlNsModulePayload

<pre>
OcamlNsModulePayload(<a href="#OcamlNsModulePayload-ns">ns</a>, <a href="#OcamlNsModulePayload-sep">sep</a>, <a href="#OcamlNsModulePayload-cmx">cmx</a>, <a href="#OcamlNsModulePayload-o">o</a>, <a href="#OcamlNsModulePayload-cmo">cmo</a>, <a href="#OcamlNsModulePayload-cmi">cmi</a>)
</pre>

OCaml NS Module payload provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlNsModulePayload-ns"></a>ns |  namespace string    |
| <a id="OcamlNsModulePayload-sep"></a>sep |  separator string    |
| <a id="OcamlNsModulePayload-cmx"></a>cmx |  .cmx file produced from the target (native mode)    |
| <a id="OcamlNsModulePayload-o"></a>o |  .o file produced from the target (native mode)    |
| <a id="OcamlNsModulePayload-cmo"></a>cmo |  .cmo file produced from the target (native mode)    |
| <a id="OcamlNsModulePayload-cmi"></a>cmi |  .cmi file produced from the target    |


<a id="#OcamlNsModuleProvider"></a>

## OcamlNsModuleProvider

<pre>
OcamlNsModuleProvider(<a href="#OcamlNsModuleProvider-payload">payload</a>, <a href="#OcamlNsModuleProvider-deps">deps</a>)
</pre>

OCaml module provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlNsModuleProvider-payload"></a>payload |  An [OcamlNsModulePayload](#ocamlnsmodulepayload) structure.    |
| <a id="OcamlNsModuleProvider-deps"></a>deps |  An [OcamlDepsetProvider](#ocamldepsetprovider)    |


