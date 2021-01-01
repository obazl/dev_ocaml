<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a id="#OcamlArchivePayload"></a>

## OcamlArchivePayload

<pre>
OcamlArchivePayload(<a href="#OcamlArchivePayload-archive">archive</a>, <a href="#OcamlArchivePayload-cmxa">cmxa</a>, <a href="#OcamlArchivePayload-a">a</a>, <a href="#OcamlArchivePayload-cma">cma</a>, <a href="#OcamlArchivePayload-cmxs">cmxs</a>, <a href="#OcamlArchivePayload-modules">modules</a>)
</pre>

A Provider struct used by [OcamlArchiveProvider](#ocamlarchiveprovider) and [PpxArchiveProvider](docs_ppx_providers.md#ppxarchiveprovider).

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlArchivePayload-archive"></a>archive |  Name of archive    |
| <a id="OcamlArchivePayload-cmxa"></a>cmxa |  .cmxa file produced by the target (native mode)    |
| <a id="OcamlArchivePayload-a"></a>a |  .a file produced by the target (native mode)    |
| <a id="OcamlArchivePayload-cma"></a>cma |  .cma file produced by the target (bytecode mode)    |
| <a id="OcamlArchivePayload-cmxs"></a>cmxs |  .cmxs file produced by the target  (shared object)    |
| <a id="OcamlArchivePayload-modules"></a>modules |  list of cmx files archived    |


<a id="#OcamlArchiveProvider"></a>

## OcamlArchiveProvider

<pre>
OcamlArchiveProvider(<a href="#OcamlArchiveProvider-payload">payload</a>, <a href="#OcamlArchiveProvider-deps">deps</a>)
</pre>

OCaml library provider. A library is a collection of modules.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlArchiveProvider-payload"></a>payload |  An [OcamlArchivePayload](#ocamlarchivepayload) provider    |
| <a id="OcamlArchiveProvider-deps"></a>deps |  An [OcamlDepset](#ocamldepset) provider.    |


<a id="#OcamlDepset"></a>

## OcamlDepset

<pre>
OcamlDepset(<a href="#OcamlDepset-opam">opam</a>, <a href="#OcamlDepset-nopam">nopam</a>, <a href="#OcamlDepset-cclib">cclib</a>)
</pre>

A Provider struct used by OBazl rules to provide heterogenous dependencies.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlDepset-opam"></a>opam |  direct and indirect opam deps (Labels) of target    |
| <a id="OcamlDepset-nopam"></a>nopam |  direct and indirect non-opam deps (Files) of target    |
| <a id="OcamlDepset-cclib"></a>cclib |  C/C++ lib deps    |


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


<a id="#OcamlInterfaceProvider"></a>

## OcamlInterfaceProvider

<pre>
OcamlInterfaceProvider(<a href="#OcamlInterfaceProvider-payload">payload</a>, <a href="#OcamlInterfaceProvider-deps">deps</a>)
</pre>

OCaml interface provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlInterfaceProvider-payload"></a>payload |  A struct with the following fields:             cmi: .cmi file produced by the target             ml:  .ml source file. without the source file, the cmi file will be ignored!    |
| <a id="OcamlInterfaceProvider-deps"></a>deps |  A pair of depsets:             opam : direct and transitive opam deps (Labels) of target             nopam: direct and transitive non-opam deps (Files) of target    |


<a id="#OcamlLibraryProvider"></a>

## OcamlLibraryProvider

<pre>
OcamlLibraryProvider(<a href="#OcamlLibraryProvider-payload">payload</a>, <a href="#OcamlLibraryProvider-deps">deps</a>)
</pre>

OCaml library provider. A library is a collection of modules.

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
| <a id="OcamlModulePayload-cmx"></a>cmx |  .cmx file produced by the target (native mode)    |
| <a id="OcamlModulePayload-o"></a>o |  .o file produced by the target (native mode)    |
| <a id="OcamlModulePayload-cmo"></a>cmo |  .cmo file produced by the target (bytecode mode)    |
| <a id="OcamlModulePayload-cmi"></a>cmi |  .cmi file produced by the target (optional)    |
| <a id="OcamlModulePayload-mli"></a>mli |  .mli source file (optional)    |
| <a id="OcamlModulePayload-cmt"></a>cmt |  .cmt file produced by the target (optional)    |


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
| <a id="OcamlModuleProvider-deps"></a>deps |  An [OcamlDepset](#ocamldepset) provider.    |


<a id="#OcamlNsModuleProvider"></a>

## OcamlNsModuleProvider

<pre>
OcamlNsModuleProvider(<a href="#OcamlNsModuleProvider-payload">payload</a>, <a href="#OcamlNsModuleProvider-deps">deps</a>)
</pre>

OCaml module provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="OcamlNsModuleProvider-payload"></a>payload |  A struct with the following fields:             ns : namespace             cmi: .cmi file produced by the target             cm : .cmx/cmo file produced by the target             o  : .o file produced by the target    |
| <a id="OcamlNsModuleProvider-deps"></a>deps |  A pair of depsets:             opam : direct and transitive opam deps (Labels) of target             nopam: direct and transitive non-opam deps (Files) of target    |


