<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a id="#PpxArchiveProvider"></a>

## PpxArchiveProvider

<pre>
PpxArchiveProvider(<a href="#PpxArchiveProvider-payload">payload</a>, <a href="#PpxArchiveProvider-deps">deps</a>)
</pre>

OCaml PPX archive provider.

**FIELDS**


| Name  | Description |
| ------------- | ------------- |
| <a id="PpxArchiveProvider-payload"></a>payload |  An [OcamlArchivePayload](docs_ocaml_providers.md#ocamlarchivepayload) provider    |
| <a id="PpxArchiveProvider-deps"></a>deps |  A pair of depsets:             opam : direct and transitive opam deps (Labels) of target             opam_lazy : extension output deps; needed when transformed source is compiled             nopam: direct and transitive non-opam deps (Files) of target             nopam_lazy : extension output deps; needed when transformed source is compiled    |


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


