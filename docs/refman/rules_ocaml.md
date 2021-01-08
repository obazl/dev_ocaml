[Reference Manual](index.md)

# ocaml rules
**WARNING** Beta version - subject to change

----

**Rules**:

* [ocaml_archive](#ocaml_archive)
* [ocaml_executable](#ocaml_executable)
* [ocaml_import](#ocaml_import)
* [ocaml_interface](#ocaml_interface)
* [ocaml_library](#ocaml_library)
* [ocaml_module](#ocaml_module)
* [ocaml_ns](#ocaml_ns)

**<a name="configdefs">OCaml Rules - Configurable defaults</a>**:

These options apply to all `ocaml_*` rules. They can be overridden on
the command line; for example, to enable verbosity (`-verbose`) for
all `ocaml_*` build targets, pass `--@ocaml//verbose`. See
[Configurable_Defaults](../ug/configurable_defaults.md) for more
information.

**Options** May be enums, strings, labels, etc.

| Label | Default |  |
| ----- | ------- | ------- |
| @ocaml//mode | @ocaml//mode:bytecode | Enum: :bytecode, :native |

**Boolean Flags** Each boolean flag `foo` may be enabled by
`--@ocaml//foo` or `--@ocaml//foo:enable`, and disabled with
`--no@ocaml//foo` or `--@ocaml//foo:disable`. Each flag has a
corresponding OCaml option and an OBazl (not an OCaml) negation; see
[Configurable_Defaults:
Disabling](../ug/configurable_defaults.md#disabling) for information
on how to use negated options to override defaults.

In addition to these, which apply to all `ocaml_*` rules, each rule
may have its own set of configurable defaults.

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
| @ocaml//verbose<sup>1</sup> | disabled | `-verbose`, `-no-verbose` |

<sup>1</sup> Each `ocaml_*` rule also has it's own `verbose` flag.

----

----

<a name="#ocaml_archive" id="#ocaml_archive"></a>

## ocaml_archive

<pre>
ocaml_archive(<a href="#ocaml_archive-name">name</a>, <a href="#ocaml_archive-archive_name">archive_name</a>, <a href="#ocaml_archive-cc_deps">cc_deps</a>, <a href="#ocaml_archive-cc_linkall">cc_linkall</a>, <a href="#ocaml_archive-cc_linkopts">cc_linkopts</a>, <a href="#ocaml_archive-deps">deps</a>, <a href="#ocaml_archive-doc">doc</a>, <a href="#ocaml_archive-linkshared">linkshared</a>, <a href="#ocaml_archive-opts">opts</a>)
</pre>

Generates an OCaml archive file.

**ATTRIBUTES** for rule `ocaml_archive`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_archive-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_archive-archive_name"></a>archive_name |  Name of output file. Overrides default, which is derived from _name_ attribute.   | String | optional | "" |
| <a id="ocaml_archive-cc_deps"></a>cc_deps |  Dictionary specifying C/C++ library dependencies. Key: a target label; value: a linkmode string, which determines which file to link. Valid linkmodes: 'default', 'static', 'dynamic', 'shared' (synonym for 'dynamic'). For more information see [CC Dependencies: Linkmode](../ug/cc_deps.md#linkmode).   Providers:   [CcInfo](providers_ocaml.md#ccinfo)    | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_archive-cc_linkall"></a>cc_linkall |  True: use <code>-whole-archive</code> (GCC toolchain) or <code>-force_load</code> (Clang toolchain). Deps in this attribute must also be listed in cc_deps.   Providers:   [CcInfo](providers_ocaml.md#ccinfo)    | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_archive-cc_linkopts"></a>cc_linkopts |  List of C/C++ link options. E.g. <code>["-lstd++"]</code>.   | List of strings | optional | [] |
| <a id="ocaml_archive-deps"></a>deps |  List of OCaml dependencies. See [Dependencies](#deps) for details.   Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)    [OcamlImportProvider](providers_ocaml.md#ocamlimportprovider)    [OcamlInterfaceProvider](providers_ocaml.md#ocamlinterfaceprovider)    [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)    [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)    [OcamlNsModuleProvider](providers_ocaml.md#ocamlnsmoduleprovider)    [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)    [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider)    | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_archive-doc"></a>doc |  Deprecated   | String | optional | "" |
| <a id="ocaml_archive-linkshared"></a>linkshared |  Build a .cmxs ('plugin') for dynamic loading. Native mode only.   | Boolean | optional | False |
| <a id="ocaml_archive-opts"></a>opts |  List of OCaml options. Will override configurable default options.   | List of strings | optional | [] |



----

<a name="#ocaml_executable" id="#ocaml_executable"></a>

## ocaml_executable

<pre>
ocaml_executable(<a href="#ocaml_executable-name">name</a>, <a href="#ocaml_executable-cc_deps">cc_deps</a>, <a href="#ocaml_executable-cc_linkall">cc_linkall</a>, <a href="#ocaml_executable-cc_linkopts">cc_linkopts</a>, <a href="#ocaml_executable-data">data</a>, <a href="#ocaml_executable-deps">deps</a>, <a href="#ocaml_executable-exe_name">exe_name</a>, <a href="#ocaml_executable-main">main</a>, <a href="#ocaml_executable-message">message</a>, <a href="#ocaml_executable-opts">opts</a>,
                 <a href="#ocaml_executable-strip_data_prefixes">strip_data_prefixes</a>)
</pre>

Generates an OCaml executable binary. [User Guide](../ug/ocaml_executable.md).  Provides only standard DefaultInfo provider.

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
| <a id="ocaml_executable-data"></a>data |  Runtime dependencies: list of labels of data files needed by this executable at runtime.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-deps"></a>deps |  List of OCaml dependencies. See [Dependencies](#deps) for details.   Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)    [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)    [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)    [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)    [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider)    [CcInfo](providers_ocaml.md#ccinfo)    | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-exe_name"></a>exe_name |  Name for output executable file.  Overrides 'name' attribute.   | String | optional | "" |
| <a id="ocaml_executable-main"></a>main |  Label of module containing entry point of executable. This module will be placed last in the list of dependencies.   Providers:   [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)    [OpamPkgInfo](providers_ocaml.md#opampkginfo)    | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_executable-message"></a>message |  Deprecated   | String | optional | "" |
| <a id="ocaml_executable-opts"></a>opts |  List of OCaml options. Will override configurable default options.   | List of strings | optional | [] |
| <a id="ocaml_executable-strip_data_prefixes"></a>strip_data_prefixes |  Symlink each data file to the basename part in the runfiles root directory. E.g. test/foo.data -&gt; foo.data.   | Boolean | optional | False |



----

<a name="#ocaml_import" id="#ocaml_import"></a>

## ocaml_import

<pre>
ocaml_import(<a href="#ocaml_import-name">name</a>)
</pre>

Imports a pre-compiled OCaml binary. [User Guide](../ug/ocaml_import.md).

**NOT YET SUPPORTED**
    

**ATTRIBUTES** for rule `ocaml_import`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_import-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |



----

<a name="#ocaml_interface" id="#ocaml_interface"></a>

## ocaml_interface

<pre>
ocaml_interface(<a href="#ocaml_interface-name">name</a>, <a href="#ocaml_interface-deps">deps</a>, <a href="#ocaml_interface-msg">msg</a>, <a href="#ocaml_interface-ns">ns</a>, <a href="#ocaml_interface-opts">opts</a>, <a href="#ocaml_interface-ppx">ppx</a>, <a href="#ocaml_interface-ppx_args">ppx_args</a>, <a href="#ocaml_interface-ppx_data">ppx_data</a>, <a href="#ocaml_interface-ppx_print">ppx_print</a>, <a href="#ocaml_interface-src">src</a>)
</pre>

Generates OCaml .cmi (inteface) file. [User Guide](../ug/ocaml_interface.md). Provides `OcamlInterfaceProvider`.

**CONFIGURABLE DEFAULTS** for rule `ocaml_executable`

In addition to the [OCaml configurable defaults](#configdefs) that apply to all
`ocaml_*` rules, the following apply to this rule:

| Label | Default | `opts` attrib |
| ----- | ------- | ------- |
| @ocaml//interface:linkall | True | `-linkall`, `-no-linkall`|
| @ocaml//interface:threads | True | `-thread`, `-no-thread`|
| @ocaml//interface:warnings | `@1..3@5..28@30..39@43@46..47@49..57@61..62-40`| `-w` plus option value |

**NOTE** These do not support `:enable`, `:disable` syntax.

 See [Configurable Defaults](../ug/configdefs_doc.md) for more information.
    

**ATTRIBUTES** for rule `ocaml_interface`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_interface-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_interface-deps"></a>deps |  List of OCaml dependencies. See [Dependencies](#deps) for details.   Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)    [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)    [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)    [OcamlNsModuleProvider](providers_ocaml.md#ocamlnsmoduleprovider)    [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider)    [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)    | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_interface-msg"></a>msg |  Deprecated   | String | optional | "" |
| <a id="ocaml_interface-ns"></a>ns |  Label of an <code>ocaml_ns</code> target. Used to derive namespace, output name, -open arg, etc.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_interface-opts"></a>opts |  List of OCaml options. Will override configurable default options.   | List of strings | optional | [] |
| <a id="ocaml_interface-ppx"></a>ppx |  Label of <code>ppx_executable</code> target to be used to transform source before compilation.   Providers:   [PpxExecutableProvider](providers_ocaml.md#ppxexecutableprovider)    | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_interface-ppx_args"></a>ppx_args |  Options to pass to PPX executable.   | List of strings | optional | [] |
| <a id="ocaml_interface-ppx_data"></a>ppx_data |  PPX runtime dependencies. List of labels of files needed by PPX at preprocessing runtime. E.g. a file used by <code>[%%import ]</code> from [ppx_optcomp](https://github.com/janestreet/ppx_optcomp).   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_interface-ppx_print"></a>ppx_print |  Format of output of PPX transform. Value must be one of '@ppx//print:binary', '@ppx//print:text'. See [PPX: ppx_print](../ug/ppx.md#ppx_print) for more information.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @ppx//print:binary |
| <a id="ocaml_interface-src"></a>src |  A single .mli source file label   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |



----

<a name="#ocaml_library" id="#ocaml_library"></a>

## ocaml_library

<pre>
ocaml_library(<a href="#ocaml_library-name">name</a>, <a href="#ocaml_library-cc_deps">cc_deps</a>, <a href="#ocaml_library-cc_linkall">cc_linkall</a>, <a href="#ocaml_library-cc_linkopts">cc_linkopts</a>, <a href="#ocaml_library-deps">deps</a>, <a href="#ocaml_library-doc">doc</a>, <a href="#ocaml_library-lib_name">lib_name</a>, <a href="#ocaml_library-msg">msg</a>, <a href="#ocaml_library-opts">opts</a>, <a href="#ocaml_library-srcs">srcs</a>)
</pre>

Aggregates a collection of OCaml modules. [User Guide](../ug/ocaml_library.md). Provides: [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider).

**WARNING** Not yet fully supported - subject to change. Use with caution.

An `ocaml_library` is a collection of modules packaged into an OBazl
target; it is not a single binary file. It is a OBazl convenience rule
that allows a target to depend on a collection of deps under a single
label, rather than having to list each individually.

Be careful not to confuse `ocaml_library` with `ocaml_archive`. The
latter generates OCaml binaries (`.cma`, `.cmxa`, '.a' archive files);
the former does not generate anything, it just passes on its
dependencies under a single label, packaged in a
[OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider). For
more information see [Collections: Libraries, Archives and
Packages](../ug/collections.md).

**<a name="deps">Dependencies</a>**: each entry in the `deps` list must provide one or more of the following Providers:

- [OpamPkgInfo](providers_ocaml.md#opampkginfo)
- [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider) The OCaml compiler does not allow an archive to depend on an archive, but the OBazl rules support this.
- [OcamlInterfaceProvider](providers_ocaml.md#ocamlinterfaceprovider)
- [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)
- [OcamlNsModuleProvider](providers_ocaml.md#ocamlnsmoduleprovider)
- [PpxArchiveProvider](providers_ppx.md#ppxarchiveprovider)

See [OCaml Dependencies](../ug/ocaml_deps.md) for more information on OCaml dependencies.

    

**ATTRIBUTES** for rule `ocaml_library`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_library-cc_deps"></a>cc_deps |  Target labels of hermetic (bazelized) C/C++ library dependencies.   Providers:   [CcInfo](providers_ocaml.md#ccinfo)    | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_library-cc_linkall"></a>cc_linkall |  List of libs using -whole-archive (GCC toolchain) or -force_load (Clang toolchain)   Providers:   [CcInfo](providers_ocaml.md#ccinfo)    | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_library-cc_linkopts"></a>cc_linkopts |  Non-hermetic C/C++ options, e.g. -lopenssl   | List of strings | optional | [] |
| <a id="ocaml_library-deps"></a>deps |  -   Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)    [OcamlImportProvider](providers_ocaml.md#ocamlimportprovider)    [OcamlInterfaceProvider](providers_ocaml.md#ocamlinterfaceprovider)    [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)    [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)    [OcamlNsModuleProvider](providers_ocaml.md#ocamlnsmoduleprovider)    [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)    [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider)    | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_library-doc"></a>doc |  -   | String | optional | "" |
| <a id="ocaml_library-lib_name"></a>lib_name |  -   | String | optional | "" |
| <a id="ocaml_library-msg"></a>msg |  -   | String | optional | "" |
| <a id="ocaml_library-opts"></a>opts |  -   | List of strings | optional | [] |
| <a id="ocaml_library-srcs"></a>srcs |  -   Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)    [OcamlImportProvider](providers_ocaml.md#ocamlimportprovider)    [OcamlInterfaceProvider](providers_ocaml.md#ocamlinterfaceprovider)    [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)    [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)    [OcamlNsModuleProvider](providers_ocaml.md#ocamlnsmoduleprovider)    [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)    [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider)    | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |



----

<a name="#ocaml_module" id="#ocaml_module"></a>

## ocaml_module

<pre>
ocaml_module(<a href="#ocaml_module-name">name</a>, <a href="#ocaml_module-cc_deps">cc_deps</a>, <a href="#ocaml_module-cc_linkall">cc_linkall</a>, <a href="#ocaml_module-cc_linkopts">cc_linkopts</a>, <a href="#ocaml_module-cc_linkstatic">cc_linkstatic</a>, <a href="#ocaml_module-cc_opts">cc_opts</a>, <a href="#ocaml_module-data">data</a>, <a href="#ocaml_module-deps">deps</a>, <a href="#ocaml_module-doc">doc</a>,
             <a href="#ocaml_module-dual_mode">dual_mode</a>, <a href="#ocaml_module-intf">intf</a>, <a href="#ocaml_module-module_name">module_name</a>, <a href="#ocaml_module-msg">msg</a>, <a href="#ocaml_module-ns">ns</a>, <a href="#ocaml_module-ns_sep">ns_sep</a>, <a href="#ocaml_module-opts">opts</a>, <a href="#ocaml_module-ppx">ppx</a>, <a href="#ocaml_module-ppx_args">ppx_args</a>, <a href="#ocaml_module-ppx_data">ppx_data</a>, <a href="#ocaml_module-ppx_print">ppx_print</a>,
             <a href="#ocaml_module-ppx_tags">ppx_tags</a>, <a href="#ocaml_module-src">src</a>)
</pre>

Compiles an OCaml module. [User Guide](../ug/ocaml_module.md).  Provides: [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider).

**CONFIGURABLE DEFAULTS** for rule `ocaml_module`

In addition to the [OCaml configurable defaults](#configdefs) that apply to all
`ocaml_*` rules, the following apply to this rule:

**Options**

| Label | Default | Notes |
| ----- | ------- | ------- |
| @ocaml//module:deps | `@ocaml//:null` | list of OCaml deps to add to all `ocaml_module` instances |
| @ocaml//module:cc_deps<sup>1</sup> | `@ocaml//:null` | list of cc_deps to add to all `ocaml_module` instances |
| @ocaml//module:cc_linkstatic<sup>1</sup> | `@ocaml//:null` | list of cc_deps to link statically (DEPRECATED) |
| @ocaml//module:warnings | `@1..3@5..28@30..39@43@46..47@49..57@61..62-40`| sets `-w` option for all `ocaml_module` instances |

<sup>1</sup> See [CC Dependencies](../ug/cc_deps.md) for more information on CC deps.

**Boolean Flags**

| Label | Default | `opts` attrib |
| ----- | ------- | ------- |
| @ocaml//module:linkall | True | `-linkall`, `-no-linkall`|
| @ocaml//module:threads | True | `-thread`, `-no-thread`|
| @ocaml//module:verbose | True | `-verbose`, `-no-verbose`|

**NOTE** These do not support `:enable`, `:disable` syntax.

 See [Configurable Defaults](../ug/configdefs_doc.md) for more information.
    

**ATTRIBUTES** for rule `ocaml_module`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_module-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_module-cc_deps"></a>cc_deps |  Dictionary specifying C/C++ library dependencies. Key: a target label; value: a linkmode string, which determines which file to link. Valid linkmodes: 'default', 'static', 'dynamic', 'shared' (synonym for 'dynamic'). For more information see [CC Dependencies: Linkmode](../ug/cc_deps.md#linkmode).   | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_module-cc_linkall"></a>cc_linkall |  True: use <code>-whole-archive</code> (GCC toolchain) or <code>-force_load</code> (Clang toolchain). Deps in this attribute must also be listed in cc_deps.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_module-cc_linkopts"></a>cc_linkopts |  List of C/C++ link options. E.g. <code>["-lstd++"]</code>.   | List of strings | optional | [] |
| <a id="ocaml_module-cc_linkstatic"></a>cc_linkstatic |  DEPRECATED. Control linkage of C/C++ dependencies. True: link to .a file; False: link to shared object file (.so or .dylib)   | Boolean | optional | True |
| <a id="ocaml_module-cc_opts"></a>cc_opts |  C/C++ options   | List of strings | optional | [] |
| <a id="ocaml_module-data"></a>data |  Runtime dependencies: list of labels of data files needed by this module at runtime.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_module-deps"></a>deps |  List of OCaml dependencies. See [Dependencies](#deps) for details.   Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)    [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)    [OcamlInterfaceProvider](providers_ocaml.md#ocamlinterfaceprovider)    [OcamlImportProvider](providers_ocaml.md#ocamlimportprovider)    [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)    [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)    [OcamlNsModuleProvider](providers_ocaml.md#ocamlnsmoduleprovider)    [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider)    [PpxModuleProvider](providers_ocaml.md#ppxmoduleprovider)    [CcInfo](providers_ocaml.md#ccinfo)    | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_module-doc"></a>doc |  Docstring for module   | String | optional | "" |
| <a id="ocaml_module-dual_mode"></a>dual_mode |  -   | Boolean | optional | False |
| <a id="ocaml_module-intf"></a>intf |  Single label of a target providing a single .cmi or .mli file. Optional. Currently only supports .cmi input.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_module-module_name"></a>module_name |  Module name.   | String | optional | "" |
| <a id="ocaml_module-msg"></a>msg |  -   | String | optional | "" |
| <a id="ocaml_module-ns"></a>ns |  Label of an ocaml_ns target. Used to derive namespace, output name, -open arg, etc.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_module-ns_sep"></a>ns_sep |  Namespace separator.  Default: '__'   | String | optional | "__" |
| <a id="ocaml_module-opts"></a>opts |  List of OCaml options. Will override configurable default options.   | List of strings | optional | [] |
| <a id="ocaml_module-ppx"></a>ppx |  PPX binary (executable).   Providers:   [PpxExecutableProvider](providers_ocaml.md#ppxexecutableprovider)    | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_module-ppx_args"></a>ppx_args |  Options to pass to PPX binary.   | List of strings | optional | [] |
| <a id="ocaml_module-ppx_data"></a>ppx_data |  PPX runtime dependencies. List of labels of files needed by PPX at preprocessing runtime. E.g. a file used by <code>[%%import ]</code> from [ppx_optcomp](https://github.com/janestreet/ppx_optcomp).   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_module-ppx_print"></a>ppx_print |  Format of output of PPX transform. Value must be one of '@ppx//print:binary', '@ppx//print:text'.  See [PPX](../ug/ppx.md#ppx_print) for more information   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @ppx//print |
| <a id="ocaml_module-ppx_tags"></a>ppx_tags |  List of tags.  Used to set e.g. -inline-test-libs, --cookies. Currently only one tag allowed.   | List of strings | optional | [] |
| <a id="ocaml_module-src"></a>src |  A single .ml source file label.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |



----

<a name="#ocaml_ns" id="#ocaml_ns"></a>

## ocaml_ns

<pre>
ocaml_ns(<a href="#ocaml_ns-name">name</a>, <a href="#ocaml_ns-ns">ns</a>, <a href="#ocaml_ns-ns_sep">ns_sep</a>, <a href="#ocaml_ns-submodules">submodules</a>)
</pre>

Generate a 'namespace' module. [User Guide](../ug/ocaml_ns.md).  Provides: [OcamlNsModuleProvider](providers_ocaml.md#ocamlnsmoduleprovider).

See [Namespacing](../ug/namespacing.md) for more information on namespaces.

    

**ATTRIBUTES** for rule `ocaml_ns`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_ns-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_ns-ns"></a>ns |  A namespace name string. The name of namespace is taken from this attribute, not the <code>name</code> attribute.  This makes it easier to avoid naming conflicts when a package contains a large number of modules, archives, etc.   | String | optional | "" |
| <a id="ocaml_ns-ns_sep"></a>ns_sep |  Namespace separator.  Default: '__' (double underscore)   | String | optional | "__" |
| <a id="ocaml_ns-submodules"></a>submodules |  List of all submodule source files, including .ml/.mli file(s) whose name matches the ns.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |



