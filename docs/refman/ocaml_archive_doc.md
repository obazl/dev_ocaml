<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a id="#ocaml_archive"></a>

## ocaml_archive

<pre>
ocaml_archive(<a href="#ocaml_archive-name">name</a>, <a href="#ocaml_archive-archive_name">archive_name</a>, <a href="#ocaml_archive-cc_deps">cc_deps</a>, <a href="#ocaml_archive-cc_linkall">cc_linkall</a>, <a href="#ocaml_archive-cc_linkopts">cc_linkopts</a>, <a href="#ocaml_archive-deps">deps</a>, <a href="#ocaml_archive-doc">doc</a>, <a href="#ocaml_archive-linkopts">linkopts</a>, <a href="#ocaml_archive-linkshared">linkshared</a>,
              <a href="#ocaml_archive-opts">opts</a>)
</pre>

Generates an OCaml archive file. Provides: [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider).

**<a name="deps">Dependencies</a>**: each entry in the `deps` list must provide one or more of the following Providers:

- [OpamPkgInfo](providers_ocaml.md#opampkginfo)
- [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider) The OCaml compiler does not allow an archive to depend on an archive, but the OBazl rules support this.
- [OcamlInterfaceProvider](providers_ocaml.md#ocamlinterfaceprovider)
- [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)
- [OcamlNsModuleProvider](providers_ocaml.md#ocamlnsmoduleprovider)
- [PpxArchiveProvider](providers_ppx.md#ppxarchiveprovider)

See [OCaml Dependencies](../ug/ocaml_deps.md) for more information on OCaml dependencies.

    

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_archive-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_archive-archive_name"></a>archive_name |  Name of output file. Overrides default, which is derived from _name_ attribute.   | String | optional | "" |
| <a id="ocaml_archive-cc_deps"></a>cc_deps |  Dictionary specifying C/C++ library dependencies. Key: a target label; value: a linkmode string, which determines which file to link. Valid linkmodes: 'default', 'static', 'dynamic', 'shared' (synonym for 'dynamic'). For more information see [CC Dependencies: Linkmode](../ug/cc_deps.md#linkmode).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_archive-cc_linkall"></a>cc_linkall |  True: use -whole-archive (GCC toolchain) or -force_load (Clang toolchain)   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_archive-cc_linkopts"></a>cc_linkopts |  List of C/C++ link options. E.g. <code>["-lstd++"]</code>.   | List of strings | optional | [] |
| <a id="ocaml_archive-deps"></a>deps |  List of dependencies. See [Dependencies](#deps) for details.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_archive-doc"></a>doc |  Deprecated   | String | optional | "" |
| <a id="ocaml_archive-linkopts"></a>linkopts |  List of OCaml link options.   | List of strings | optional | [] |
| <a id="ocaml_archive-linkshared"></a>linkshared |  Build a .cmxs ('plugin') for dynamic loading. Native mode only.   | Boolean | optional | False |
| <a id="ocaml_archive-opts"></a>opts |  List of OCaml options. Will override global default options.   | List of strings | optional | [] |


