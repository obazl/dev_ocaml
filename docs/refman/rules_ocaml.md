# obazl_rules_ocaml - ocaml rules
**WARNING** Beta version - subject to change

**Rules**:

* [ocaml_archive](#ocaml_archive)
* [ocaml_executable](#ocaml_executable)
* [ocaml_interface](#ocaml_interface)
* [ocaml_module](#ocaml_module)
* [ocaml_ns](#ocaml_ns)

**Configurable options**:

These options apply to all `ocaml_*` rules. They can be overridden on
the command line; for example, to enable verbosity (`-verbose`) for all
`ocaml_*` build targets, pass `--@ocaml//verbose`. See [Configurable
Defaults](configdefs_doc.md) for more information.

| Label | Default | Enabled effect<sup>1</sup> |
| ----- | ------- | ------- |
| @ocaml//debug | disabled | Add `-g`|
| @ocaml//cmt | disabled | Add `-bin-annot`, which tells the compiler to emit `.cmt/.cmti` files |
| @ocaml//keep-locs | enabled | Add `-keep-locs` |
| @ocaml//noassert | enabled | |
| @ocaml//opaque | enabled | |
| @ocaml//short-paths | enabled | |
| @ocaml//strict-formats | enabled | |
| @ocaml//strict-sequence | enabled | |
| @ocaml//verbose | disabled | |

<sup>1</sup> Note that the authoritative source of documentation for
  OCaml compile flags is the compiler `--help` option. At time of
  writing, the official OCaml manual is incomplete (for example, it
  does not document `-keep-locs`).

----

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


<a id="#ocaml_executable"></a>

## ocaml_executable

<pre>
ocaml_executable(<a href="#ocaml_executable-name">name</a>, <a href="#ocaml_executable-cc_deps">cc_deps</a>, <a href="#ocaml_executable-cc_linkall">cc_linkall</a>, <a href="#ocaml_executable-cc_linkopts">cc_linkopts</a>, <a href="#ocaml_executable-cc_linkstatic">cc_linkstatic</a>, <a href="#ocaml_executable-copts">copts</a>, <a href="#ocaml_executable-data">data</a>, <a href="#ocaml_executable-deps">deps</a>, <a href="#ocaml_executable-exe_name">exe_name</a>,
                 <a href="#ocaml_executable-linkopts">linkopts</a>, <a href="#ocaml_executable-main">main</a>, <a href="#ocaml_executable-message">message</a>, <a href="#ocaml_executable-opts">opts</a>, <a href="#ocaml_executable-strip_data_prefixes">strip_data_prefixes</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_executable-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_executable-cc_deps"></a>cc_deps |  C/C++ library dependencies   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_executable-cc_linkall"></a>cc_linkall |  True: use -whole-archive (GCC toolchain) or -force_load (Clang toolchain). Deps in this attribute must also be listed in cc_deps.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-cc_linkopts"></a>cc_linkopts |  C/C++ link options   | List of strings | optional | [] |
| <a id="ocaml_executable-cc_linkstatic"></a>cc_linkstatic |  Control linkage of C/C++ dependencies. True: link to .a file; False: link to shared object file (.so or .dylib)   | Boolean | optional | True |
| <a id="ocaml_executable-copts"></a>copts |  -   | List of strings | optional | [] |
| <a id="ocaml_executable-data"></a>data |  Data files used by this executable.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-deps"></a>deps |  Dependencies. Do not include preprocessor (PPX) deps.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-exe_name"></a>exe_name |  -   | String | optional | "" |
| <a id="ocaml_executable-linkopts"></a>linkopts |  -   | List of strings | optional | [] |
| <a id="ocaml_executable-main"></a>main |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_executable-message"></a>message |  -   | String | optional | "" |
| <a id="ocaml_executable-opts"></a>opts |  List of OCaml options. Will override global default options.   | List of strings | optional | [] |
| <a id="ocaml_executable-strip_data_prefixes"></a>strip_data_prefixes |  Symlink each data file to the basename part in the runfiles root directory. E.g. test/foo.data -&gt; foo.data.   | Boolean | optional | False |


<a id="#ocaml_interface"></a>

## ocaml_interface

<pre>
ocaml_interface(<a href="#ocaml_interface-name">name</a>, <a href="#ocaml_interface-data">data</a>, <a href="#ocaml_interface-deps">deps</a>, <a href="#ocaml_interface-linkall">linkall</a>, <a href="#ocaml_interface-linkopts">linkopts</a>, <a href="#ocaml_interface-module_name">module_name</a>, <a href="#ocaml_interface-msg">msg</a>, <a href="#ocaml_interface-ns">ns</a>, <a href="#ocaml_interface-ns_sep">ns_sep</a>, <a href="#ocaml_interface-opts">opts</a>, <a href="#ocaml_interface-ppx">ppx</a>,
                <a href="#ocaml_interface-ppx_args">ppx_args</a>, <a href="#ocaml_interface-ppx_data">ppx_data</a>, <a href="#ocaml_interface-ppx_print">ppx_print</a>, <a href="#ocaml_interface-src">src</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_interface-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_interface-data"></a>data |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_interface-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_interface-linkall"></a>linkall |  -   | Boolean | optional | True |
| <a id="ocaml_interface-linkopts"></a>linkopts |  -   | List of strings | optional | [] |
| <a id="ocaml_interface-module_name"></a>module_name |  Module name.   | String | optional | "" |
| <a id="ocaml_interface-msg"></a>msg |  -   | String | optional | "" |
| <a id="ocaml_interface-ns"></a>ns |  Label of a ocaml_ns target. Used to derive namespace, output name, -open arg, etc.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_interface-ns_sep"></a>ns_sep |  Namespace separator.  Default: '__'   | String | optional | "__" |
| <a id="ocaml_interface-opts"></a>opts |  List of OCaml options. Will override global default options.   | List of strings | optional | [] |
| <a id="ocaml_interface-ppx"></a>ppx |  PPX binary (executable).   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_interface-ppx_args"></a>ppx_args |  Options to pass to PPX binary.   | List of strings | optional | [] |
| <a id="ocaml_interface-ppx_data"></a>ppx_data |  PPX dependencies. E.g. a file used by %%import from ppx_optcomp.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_interface-ppx_print"></a>ppx_print |  Format of output of PPX transform, binary (default) or text   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @ppx//print |
| <a id="ocaml_interface-src"></a>src |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |


<a id="#ocaml_module"></a>

## ocaml_module

<pre>
ocaml_module(<a href="#ocaml_module-name">name</a>, <a href="#ocaml_module-cc_deps">cc_deps</a>, <a href="#ocaml_module-cc_linkall">cc_linkall</a>, <a href="#ocaml_module-cc_linkstatic">cc_linkstatic</a>, <a href="#ocaml_module-cc_opts">cc_opts</a>, <a href="#ocaml_module-deps">deps</a>, <a href="#ocaml_module-doc">doc</a>, <a href="#ocaml_module-dual_mode">dual_mode</a>, <a href="#ocaml_module-intf">intf</a>,
             <a href="#ocaml_module-linkopts">linkopts</a>, <a href="#ocaml_module-module_name">module_name</a>, <a href="#ocaml_module-msg">msg</a>, <a href="#ocaml_module-ns">ns</a>, <a href="#ocaml_module-ns_sep">ns_sep</a>, <a href="#ocaml_module-opts">opts</a>, <a href="#ocaml_module-ppx">ppx</a>, <a href="#ocaml_module-ppx_args">ppx_args</a>, <a href="#ocaml_module-ppx_data">ppx_data</a>, <a href="#ocaml_module-ppx_print">ppx_print</a>,
             <a href="#ocaml_module-ppx_tags">ppx_tags</a>, <a href="#ocaml_module-src">src</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_module-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_module-cc_deps"></a>cc_deps |  C/C++ library dependencies   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_module-cc_linkall"></a>cc_linkall |  True: use -whole-archive (GCC toolchain) or -force_load (Clang toolchain)   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_module-cc_linkstatic"></a>cc_linkstatic |  Control linkage of C/C++ dependencies. True: link to .a file; False: link to shared object file (.so or .dylib)   | Boolean | optional | True |
| <a id="ocaml_module-cc_opts"></a>cc_opts |  C/C++ options   | List of strings | optional | [] |
| <a id="ocaml_module-deps"></a>deps |  -   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_module-doc"></a>doc |  Docstring for module   | String | optional | "" |
| <a id="ocaml_module-dual_mode"></a>dual_mode |  -   | Boolean | optional | False |
| <a id="ocaml_module-intf"></a>intf |  Single label of a target providing a single .cmi or .mli file. Optional. Currently only supports .cmi input.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_module-linkopts"></a>linkopts |  -   | List of strings | optional | [] |
| <a id="ocaml_module-module_name"></a>module_name |  Module name.   | String | optional | "" |
| <a id="ocaml_module-msg"></a>msg |  -   | String | optional | "" |
| <a id="ocaml_module-ns"></a>ns |  Label of an ocaml_ns target. Used to derive namespace, output name, -open arg, etc.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_module-ns_sep"></a>ns_sep |  Namespace separator.  Default: '__'   | String | optional | "__" |
| <a id="ocaml_module-opts"></a>opts |  List of OCaml options. Will override global default options.   | List of strings | optional | [] |
| <a id="ocaml_module-ppx"></a>ppx |  PPX binary (executable).   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_module-ppx_args"></a>ppx_args |  Options to pass to PPX binary.   | List of strings | optional | [] |
| <a id="ocaml_module-ppx_data"></a>ppx_data |  PPX dependencies. E.g. a file used by %%import from ppx_optcomp.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_module-ppx_print"></a>ppx_print |  Format of output of PPX transform, binary (default) or text   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @ppx//print |
| <a id="ocaml_module-ppx_tags"></a>ppx_tags |  List of tags.  Used to set e.g. -inline-test-libs, --cookies. Currently only one tag allowed.   | List of strings | optional | [] |
| <a id="ocaml_module-src"></a>src |  A single .ml source file label.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |


<a id="#ocaml_ns"></a>

## ocaml_ns

<pre>
ocaml_ns(<a href="#ocaml_ns-name">name</a>, <a href="#ocaml_ns-alwayslink">alwayslink</a>, <a href="#ocaml_ns-linkopts">linkopts</a>, <a href="#ocaml_ns-module_name">module_name</a>, <a href="#ocaml_ns-msg">msg</a>, <a href="#ocaml_ns-ns">ns</a>, <a href="#ocaml_ns-ns_sep">ns_sep</a>, <a href="#ocaml_ns-opts">opts</a>, <a href="#ocaml_ns-submodules">submodules</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_ns-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_ns-alwayslink"></a>alwayslink |  If true (default), use OCaml -linkall switch. Default: False   | Boolean | optional | False |
| <a id="ocaml_ns-linkopts"></a>linkopts |  -   | List of strings | optional | [] |
| <a id="ocaml_ns-module_name"></a>module_name |  -   | String | optional | "" |
| <a id="ocaml_ns-msg"></a>msg |  -   | String | optional | "" |
| <a id="ocaml_ns-ns"></a>ns |  -   | String | optional | "" |
| <a id="ocaml_ns-ns_sep"></a>ns_sep |  Namespace separator.  Default: '__'   | String | optional | "__" |
| <a id="ocaml_ns-opts"></a>opts |  -   | List of strings | optional | [] |
| <a id="ocaml_ns-submodules"></a>submodules |  List of all submodule source files, including .ml/.mli file(s) whose name matches the ns.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |


