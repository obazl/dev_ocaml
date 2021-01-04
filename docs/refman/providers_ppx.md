# ppx providers
**WARNING** Beta version - subject to change

[Reference Manual ToC](index.md)

----

* [PpxDepsetProvider](#ppxdepsetprovider)
* [PpxArchivePayload](#ppxarchivepayload)
* [PpxArchiveProvider](#ppxarchiveprovider)
* [PpxExecutableProvider](#ppxexecutableprovider)

<a id="#PpxArchiveProvider"></a>

## PpxArchiveProvider

<pre>
PpxArchiveProvider(<a href="#PpxArchiveProvider-payload">payload</a>, <a href="#PpxArchiveProvider-deps">deps</a>)
</pre>

OCaml PPX archive provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="PpxArchiveProvider-payload"></a>payload |  An [OcamlArchivePayload](providers_ocaml.md#OcamlArchivePayload) provider    |
| <a id="PpxArchiveProvider-deps"></a>deps |  A [PpxDepsetProvider](#ppxdepsetprovider) provider.    |


<a id="#PpxDepsetProvider"></a>

## PpxDepsetProvider

<pre>
PpxDepsetProvider(<a href="#PpxDepsetProvider-opam">opam</a>, <a href="#PpxDepsetProvider-opam_lazy">opam_lazy</a>, <a href="#PpxDepsetProvider-nopam">nopam</a>, <a href="#PpxDepsetProvider-nopam_lazy">nopam_lazy</a>)
</pre>

A Provider struct used by OBazl rules to provide heterogenous dependencies.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="PpxDepsetProvider-opam"></a>opam |  depset of OPAM deps (Labels) of target    |
| <a id="PpxDepsetProvider-opam_lazy"></a>opam_lazy |  depset of adjunct OPAM deps; needed when transformed source is compiled    |
| <a id="PpxDepsetProvider-nopam"></a>nopam |  depset of non-OPAM deps (Files) of target    |
| <a id="PpxDepsetProvider-nopam_lazy"></a>nopam_lazy |  depset of adjunct non-OPAM deps; needed when transformed source is compiled    |


<a id="#PpxExecutableProvider"></a>

## PpxExecutableProvider

<pre>
PpxExecutableProvider(<a href="#PpxExecutableProvider-payload">payload</a>, <a href="#PpxExecutableProvider-args">args</a>, <a href="#PpxExecutableProvider-deps">deps</a>)
</pre>

OCaml PPX binary provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="PpxExecutableProvider-payload"></a>payload |  Executable file produced by the target.    |
| <a id="PpxExecutableProvider-args"></a>args |  Args to be passed when binary is invoked    |
| <a id="PpxExecutableProvider-deps"></a>deps |  A triple of depsets:             opam : direct and transitive opam deps (Labels) of target             opam_lazy : extension output deps; needed when transformed source is compiled             nopam: direct and transitive non-opam deps (Files) of target             nopam_lazy : extension output deps; needed when transformed source is compiled    |


