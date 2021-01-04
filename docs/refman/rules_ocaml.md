# ocaml rules
**WARNING** Beta version - subject to change

[Reference Manual ToC](index.md)

----

**Rules**:

* [ocaml_archive](#ocaml_archive)
* [ocaml_executable](#ocaml_executable)
* [ocaml_interface](#ocaml_interface)
* [ocaml_module](#ocaml_module)
* [ocaml_ns](#ocaml_ns)

**<a name="configdefs">OCaml Rules - Configurable defaults</a>**:

These options apply to all `ocaml_*` rules. They can be overridden on
the command line; for example, to enable verbosity (`-verbose`) for all
`ocaml_*` build targets, pass `--@ocaml//verbose`. See [Configurable
Defaults](../ug/configdefs_doc.md) for more information.

| Label | Default | `opts` attrib |
| ----- | ------- | ------- |
| @ocaml//debug | disabled | `-g`, `-no-g`|
| @ocaml//cmt | disabled | `-bin-annot`, `-no-bin-annot` |
| @ocaml//keep-locs | enabled | `-keep-locs`, `-no-keep-locs` |
| @ocaml//noassert | enabled | `-noassert`, `-no-noassert` |
| @ocaml//opaque | enabled | `-opaque`, `-no-opaque` |
| @ocaml//short-paths | enabled | `-short-paths`, `-no-short-paths` |
| @ocaml//strict-formats | enabled | `-strict-formats`, `-no-strict-formats` |
| @ocaml//strict-sequence | enabled | `-strict-sequence`, `-no-strict-sequence` |
| @ocaml//verbose | disabled | `-verbose`, `-no-verbose` |

In addition to these, which apply to all `ocaml_*` rules, each such
rule may have its own set of configurable defauls.

----

<a id="#ocaml_archive"></a>

## ocaml_archive

<pre>
ocaml_archive(<a href="#ocaml_archive-name">name</a>, <a href="#ocaml_archive-archive_name">archive_name</a>, <a href="#ocaml_archive-cc_deps">cc_deps</a>, <a href="#ocaml_archive-cc_linkall">cc_linkall</a>, <a href="#ocaml_archive-cc_linkopts">cc_linkopts</a>, <a href="#ocaml_archive-deps">deps</a>, <a href="#ocaml_archive-doc">doc</a>, <a href="#ocaml_archive-linkshared">linkshared</a>, <a href="#ocaml_archive-opts">opts</a>)
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

    

**ATTRIBUTES** for rule `ocaml_archive`


| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_archive-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_archive-archive_name"></a>archive_name |  Name of output file. Overrides default, which is derived from _name_ attribute.   | String | optional | "" |
| <a id="ocaml_archive-cc_deps"></a>cc_deps |  Dictionary specifying C/C++ library dependencies. Key: a target label; value: a linkmode string, which determines which file to link. Valid linkmodes: 'default', 'static', 'dynamic', 'shared' (synonym for 'dynamic'). For more information see [CC Dependencies: Linkmode](../ug/cc_deps.md#linkmode).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_archive-cc_linkall"></a>cc_linkall |  True: use -whole-archive (GCC toolchain) or -force_load (Clang toolchain). Deps in this attribute must also be listed in cc_deps.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_archive-cc_linkopts"></a>cc_linkopts |  List of C/C++ link options. E.g. <code>["-lstd++"]</code>.   | List of strings | optional | [] |
| <a id="ocaml_archive-deps"></a>deps |  List of OCaml dependencies. See [Dependencies](#deps) for details.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_archive-doc"></a>doc |  Deprecated   | String | optional | "" |
| <a id="ocaml_archive-linkshared"></a>linkshared |  Build a .cmxs ('plugin') for dynamic loading. Native mode only.   | Boolean | optional | False |
| <a id="ocaml_archive-opts"></a>opts |  List of OCaml options. Will override global default options.   | List of strings | optional | [] |


<a id="#ocaml_executable"></a>

## ocaml_executable

<pre>
ocaml_executable(<a href="#ocaml_executable-name">name</a>, <a href="#ocaml_executable-cc_deps">cc_deps</a>, <a href="#ocaml_executable-cc_linkall">cc_linkall</a>, <a href="#ocaml_executable-cc_linkopts">cc_linkopts</a>, <a href="#ocaml_executable-data">data</a>, <a href="#ocaml_executable-deps">deps</a>, <a href="#ocaml_executable-exe_name">exe_name</a>, <a href="#ocaml_executable-main">main</a>, <a href="#ocaml_executable-message">message</a>, <a href="#ocaml_executable-opts">opts</a>,
                 <a href="#ocaml_executable-strip_data_prefixes">strip_data_prefixes</a>)
</pre>

Generates an OCaml executable binary.  Provides only standard DefaultInfo provider.

**CONFIGURABLE DEFAULTS** for rule `ocaml_executable`

In addition to the [OCaml configurable defaults](#configdefs) that apply to all
`ocaml_*` rules, the following apply to this rule:

| Label | Default | `opts` attrib |
| ----- | ------- | ------- |
| @ocaml//executable:linkall | True | `-linkall`, `-no-linkall`|
| @ocaml//executable:threads | True | `-thread`, `-no-thread`|
| @ocaml//executable:warnings | `@1..3@5..28@30..39@43@46..47@49..57@61..62-40`| `-w` plus option value |

**NOTE** These do not support `:enable`, `:disable` syntax.

 See [Configurable Defaults](../ug/configdefs_doc.md) for more information.
    

**ATTRIBUTES** for rule `ocaml_executable`


| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_executable-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_executable-cc_deps"></a>cc_deps |  Dictionary specifying C/C++ library dependencies. Key: a target label; value: a linkmode string, which determines which file to link. Valid linkmodes: 'default', 'static', 'dynamic', 'shared' (synonym for 'dynamic'). For more information see [CC Dependencies: Linkmode](../ug/cc_deps.md#linkmode).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_executable-cc_linkall"></a>cc_linkall |  True: use <code>-whole-archive</code> (GCC toolchain) or <code>-force_load</code> (Clang toolchain). Deps in this attribute must also be listed in cc_deps.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-cc_linkopts"></a>cc_linkopts |  List of C/C++ link options. E.g. <code>["-lstd++"]</code>.   | List of strings | optional | [] |
| <a id="ocaml_executable-data"></a>data |  Runtime dependencies: data files used by this executable.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-deps"></a>deps |  List of OCaml dependencies. See [Dependencies](#deps) for details.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-exe_name"></a>exe_name |  Name for output executable file.  Overrides 'name' attribute.   | String | optional | "" |
| <a id="ocaml_executable-main"></a>main |  Label of module containing entry point of executable. This module will be placed last in the list of dependencies.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_executable-message"></a>message |  Deprecated   | String | optional | "" |
| <a id="ocaml_executable-opts"></a>opts |  List of OCaml options. Will override global default options.   | List of strings | optional | [] |
| <a id="ocaml_executable-strip_data_prefixes"></a>strip_data_prefixes |  Symlink each data file to the basename part in the runfiles root directory. E.g. test/foo.data -&gt; foo.data.   | Boolean | optional | False |


<a id="#ocaml_interface"></a>

## ocaml_interface

<pre>
ocaml_interface(<a href="#ocaml_interface-name">name</a>, <a href="#ocaml_interface-data">data</a>, <a href="#ocaml_interface-deps">deps</a>, <a href="#ocaml_interface-linkall">linkall</a>, <a href="#ocaml_interface-linkopts">linkopts</a>, <a href="#ocaml_interface-module_name">module_name</a>, <a href="#ocaml_interface-msg">msg</a>, <a href="#ocaml_interface-ns">ns</a>, <a href="#ocaml_interface-ns_sep">ns_sep</a>, <a href="#ocaml_interface-opts">opts</a>, <a href="#ocaml_interface-ppx">ppx</a>,
                <a href="#ocaml_interface-ppx_args">ppx_args</a>, <a href="#ocaml_interface-ppx_data">ppx_data</a>, <a href="#ocaml_interface-ppx_print">ppx_print</a>, <a href="#ocaml_interface-src">src</a>)
</pre>



**ATTRIBUTES** for rule `ocaml_interface`


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



**ATTRIBUTES** for rule `ocaml_module`


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



**ATTRIBUTES** for rule `ocaml_ns`


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


