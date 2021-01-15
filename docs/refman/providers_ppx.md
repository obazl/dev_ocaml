[Reference Manual](index.md)

# ppx providers
**WARNING** Beta version - subject to change

* [PpxDepsetProvider](#ppxdepsetprovider)
* [PpxArchivePayload](#ppxarchivepayload)
* [PpxArchiveProvider](#ppxarchiveprovider)
* [PpxExecutableProvider](#ppxexecutableprovider)

----
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
PpxDepsetProvider(<a href="#PpxDepsetProvider-opam">opam</a>, <a href="#PpxDepsetProvider-opam_adjunct">opam_adjunct</a>, <a href="#PpxDepsetProvider-nopam">nopam</a>, <a href="#PpxDepsetProvider-nopam_adjunct">nopam_adjunct</a>, <a href="#PpxDepsetProvider-cc_deps">cc_deps</a>, <a href="#PpxDepsetProvider-cc_linkall">cc_linkall</a>)
</pre>

A Provider struct used by OBazl rules to provide heterogenous dependencies.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="PpxDepsetProvider-opam"></a>opam |  depset of OPAM deps (Labels) of target    |
| <a id="PpxDepsetProvider-opam_adjunct"></a>opam_adjunct |  depset of adjunct OPAM deps; needed when transformed source is compiled    |
| <a id="PpxDepsetProvider-nopam"></a>nopam |  depset of non-OPAM deps (Files) of target    |
| <a id="PpxDepsetProvider-nopam_adjunct"></a>nopam_adjunct |  depset of adjunct non-OPAM deps; needed when transformed source is compiled    |
| <a id="PpxDepsetProvider-cc_deps"></a>cc_deps |  depset of C/C++ lib deps    |
| <a id="PpxDepsetProvider-cc_linkall"></a>cc_linkall |  string list of cc libs to link with <code>-force_load</code> (Clang) or <code>-whole-archive</code> (Linux). (Corresponds to <code>alwayslink</code> attribute of cc_library etc., and <code>-linkall</code> option for OCaml.)    |


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
| <a id="PpxExecutableProvider-deps"></a>deps |  A triple of depsets:             opam : direct and transitive opam deps (Labels) of target             opam_adjunct : extension output deps; needed when transformed source is compiled             nopam: direct and transitive non-opam deps (Files) of target             nopam_adjunct : extension output deps; needed when transformed source is compiled    |


