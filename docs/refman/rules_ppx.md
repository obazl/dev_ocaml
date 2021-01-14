[Reference Manual](index.md)

# ppx rules
**WARNING** Beta version - subject to change

----

* [ppx_archive](#ppx_archive)
* [ppx_executable](#ppx_executable)
* [ppx_module](#ppx_module)
* [ppx_ns](#ppx_ns)
* [ppx_test](#ppx_test)

**<a name="configdefs">Ppx Rules - Configurable defaults</a>**:

These options apply to all `ppx_*` rules. They can be overridden on
the command line; for example, to enable verbosity (`-verbose`) for
all `ppx_*` build targets, pass `--@ppx//verbose`. See
[Configurable_Defaults](../ug/configurable_defaults.md) for more
information.

**Options** May be enums, strings, labels, etc.

| Label | Default |  |
| ----- | ------- | ------- |
| @ppx//mode | @ppx//mode:bytecode | Enum: :bytecode, :native |

**Boolean Flags** Each boolean flag `foo` may be enabled by
`--@ppx//foo` or `--@ppx//foo:enable`, and disabled with
`--no@ppx//foo` or `--@ppx//foo:disable`. Each flag has a
corresponding Ppx option and an OBazl (not an OCaml) negation; see
[Configurable_Defaults:
Disabling](../ug/configurable_defaults.md#disabling) for information
on how to use negated options to override defaults.

In addition to these, which apply to all `ppx_*` rules, each rule
may have its own set of configurable defaults.

| Label | Default | `opts` attrib |
| ----- | ------- | ------- |
| @ppx//debug | disabled | `-g`, `-no-g`|
| @ppx//cmt | disabled | `-bin-annot`, `-no-bin-annot` |
| @ppx//keep-locs | enabled | `-keep-locs`, `-no-keep-locs` |
| @ppx//noassert | enabled | `-noassert`, `-no-noassert` |
| @ppx//opaque | enabled | `-opaque`, `-no-opaque` |
| @ppx//short-paths | enabled | `-short-paths`, `-no-short-paths` |
| @ppx//strict-formats | enabled | `-strict-formats`, `-no-strict-formats` |
| @ppx//strict-sequence | enabled | `-strict-sequence`, `-no-strict-sequence` |
| @ppx//verbose<sup>1</sup> | disabled | `-verbose`, `-no-verbose` |

<sup>1</sup> Each `ppx_*` rule also has it's own `verbose` flag.


----

<a name="#ppx_archive" id="#ppx_archive"></a>

## ppx_archive

<pre>
ppx_archive(<a href="#ppx_archive-name">name</a>, <a href="#ppx_archive-archive_name">archive_name</a>, <a href="#ppx_archive-cc_deps">cc_deps</a>, <a href="#ppx_archive-cc_linkall">cc_linkall</a>, <a href="#ppx_archive-cc_linkopts">cc_linkopts</a>, <a href="#ppx_archive-deps">deps</a>, <a href="#ppx_archive-linkshared">linkshared</a>, <a href="#ppx_archive-msg">msg</a>, <a href="#ppx_archive-opts">opts</a>)
</pre>

Generates an OCaml archive file suitable for use as a PPX dependency.   Provides: [PpxArchiveProvider](providers_ppx.md#ppxarchiveprovider).

**ATTRIBUTES** for rule `ppx_archive`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ppx_archive-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ppx_archive-archive_name"></a>archive_name |  Name of generated archive file, without extension. Overrides <code>name</code> attribute.  | String | optional | "" |
| <a id="ppx_archive-cc_deps"></a>cc_deps |  Dictionary specifying C/C++ library dependencies. Key: a target label; value: a linkmode string, which determines which file to link. Valid linkmodes: 'default', 'static', 'dynamic', 'shared' (synonym for 'dynamic'). For more information see [CC Dependencies: Linkmode](../ug/cc_deps.md#linkmode).  Providers:   [CcInfo](providers_ocaml.md#ccinfo) | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ppx_archive-cc_linkall"></a>cc_linkall |  True: use <code>-whole-archive</code> (GCC toolchain) or <code>-force_load</code> (Clang toolchain). Deps in this attribute must also be listed in cc_deps.  Providers:   [CcInfo](providers_ocaml.md#ccinfo) | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_archive-cc_linkopts"></a>cc_linkopts |  List of C/C++ link options. E.g. <code>["-lstd++"]</code>.  | List of strings | optional | [] |
| <a id="ppx_archive-deps"></a>deps |  List of OCaml dependencies.  Providers:   [DefaultInfo](providers_ocaml.md#defaultinfo)  [PpxModuleProvider](providers_ocaml.md#ppxmoduleprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_archive-linkshared"></a>linkshared |  Generate a 'plugin', i.e. a <code>.cmxs</code> file. Adds <code>-shared</code> to command line.  | Boolean | optional | False |
| <a id="ppx_archive-msg"></a>msg |  DEPRECATED  | String | optional | "" |
| <a id="ppx_archive-opts"></a>opts |  List of OCaml options. Will override configurable default options.  | List of strings | optional | [] |



----

<a name="#ppx_executable" id="#ppx_executable"></a>

## ppx_executable

<pre>
ppx_executable(<a href="#ppx_executable-name">name</a>, <a href="#ppx_executable-adjunct_deps">adjunct_deps</a>, <a href="#ppx_executable-cc_deps">cc_deps</a>, <a href="#ppx_executable-data">data</a>, <a href="#ppx_executable-deps">deps</a>, <a href="#ppx_executable-main">main</a>, <a href="#ppx_executable-opts">opts</a>, <a href="#ppx_executable-ppx">ppx</a>, <a href="#ppx_executable-print">print</a>, <a href="#ppx_executable-runtime_args">runtime_args</a>)
</pre>

Generates a PPX executable.  Provides: [PpxExecutableProvider](providers_ppx.md#ppxexecutableprovider).

By default, this rule adds `-predicates ppx_driver` to the command line.
    

**ATTRIBUTES** for rule `ppx_executable`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ppx_executable-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ppx_executable-adjunct_deps"></a>adjunct_deps |  Adjunct dependencies.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_executable-cc_deps"></a>cc_deps |  C/C++ library dependencies  Providers:   [CcInfo](providers_ocaml.md#ccinfo) | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ppx_executable-data"></a>data |  Runtime data dependencies. E.g. a file used by %%import from ppx_optcomp.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_executable-deps"></a>deps |  Deps needed to build this ppx executable.  Providers:   [DefaultInfo](providers_ocaml.md#defaultinfo)  [PpxModuleProvider](providers_ocaml.md#ppxmoduleprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_executable-main"></a>main |  A <code>ppx_module</code> to be listed last in the list of dependencies. For more information see [Main Module](../ug/ppx.md#main_module).  Providers:   [PpxModuleProvider](providers_ocaml.md#ppxmoduleprovider)  [OpamPkgInfo](providers_ocaml.md#opampkginfo) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="ppx_executable-opts"></a>opts |  List of OCaml options. Will override configurable default options.  | List of strings | optional | [] |
| <a id="ppx_executable-ppx"></a>ppx |  PPX binary (executable).  Providers:   [PpxExecutableProvider](providers_ocaml.md#ppxexecutableprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ppx_executable-print"></a>print |  Format of output of PPX transform, binary (default) or text  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @ppx//print |
| <a id="ppx_executable-runtime_args"></a>runtime_args |  List of args that must be passed to the ppx_executable at runtime. E.g. -inline-test-lib.  | List of strings | optional | [] |



----

<a name="#ppx_module" id="#ppx_module"></a>

## ppx_module

<pre>
ppx_module(<a href="#ppx_module-name">name</a>, <a href="#ppx_module-adjunct_deps">adjunct_deps</a>, <a href="#ppx_module-cc_deps">cc_deps</a>, <a href="#ppx_module-cc_opts">cc_opts</a>, <a href="#ppx_module-data">data</a>, <a href="#ppx_module-deps">deps</a>, <a href="#ppx_module-doc">doc</a>, <a href="#ppx_module-intf">intf</a>, <a href="#ppx_module-module_name">module_name</a>, <a href="#ppx_module-msg">msg</a>, <a href="#ppx_module-ns">ns</a>, <a href="#ppx_module-opts">opts</a>,
           <a href="#ppx_module-ppx">ppx</a>, <a href="#ppx_module-ppx_args">ppx_args</a>, <a href="#ppx_module-ppx_data">ppx_data</a>, <a href="#ppx_module-ppx_print">ppx_print</a>, <a href="#ppx_module-runtime_deps">runtime_deps</a>, <a href="#ppx_module-src">src</a>)
</pre>



**ATTRIBUTES** for rule `ppx_module`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ppx_module-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ppx_module-adjunct_deps"></a>adjunct_deps |  List of [adjunct dependencies](../ug/ppx.md#adjunct_deps).  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_module-cc_deps"></a>cc_deps |  C/C++ library dependencies. Keys: lib target. Vals: 'default', 'static', 'dynamic'  Providers:   [CcInfo](providers_ocaml.md#ccinfo) | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ppx_module-cc_opts"></a>cc_opts |  C/C++ options  | List of strings | optional | [] |
| <a id="ppx_module-data"></a>data |  Runtime dependencies: list of labels of data files needed by this module at runtime.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_module-deps"></a>deps |  List of OCaml dependencies.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_module-doc"></a>doc |  Docstring  | String | optional | "" |
| <a id="ppx_module-intf"></a>intf |  Single label of a target providing a single .cmi file (not a .mli source file). Optional  Providers:   [OcamlInterfaceProvider](providers_ocaml.md#ocamlinterfaceprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ppx_module-module_name"></a>module_name |  Allows user to specify a module name different than the target name.  | String | optional | "" |
| <a id="ppx_module-msg"></a>msg |  DEPRECATED  | String | optional | "" |
| <a id="ppx_module-ns"></a>ns |  Label of a [ppx_ns](#ppx_ns) target. Used to derive namespace, output name, -open arg, etc.  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ppx_module-opts"></a>opts |  List of OCaml options. Will override configurable default options.  | List of strings | optional | [] |
| <a id="ppx_module-ppx"></a>ppx |  PPX binary (executable) used to transform source before compilation.  Providers:   [PpxExecutableProvider](providers_ocaml.md#ppxexecutableprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ppx_module-ppx_args"></a>ppx_args |  Arguments to pass to ppx executable.  (E.g. ["-cookie", "library-name=\"ppx_version\""]  | List of strings | optional | [] |
| <a id="ppx_module-ppx_data"></a>ppx_data |  PPX runtime dependencies. List of labels of files needed by PPX at preprocessing runtime. E.g. a file used by <code>[%%import ]</code> from [ppx_optcomp](https://github.com/janestreet/ppx_optcomp).  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_module-ppx_print"></a>ppx_print |  Format of output of PPX transform, binary (default) or text  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @ppx//print |
| <a id="ppx_module-runtime_deps"></a>runtime_deps |  PPX runtime dependencies. E.g. a file used by %%import from ppx_optcomp.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_module-src"></a>src |  A single .ml source file label.  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |



----

<a name="#ppx_ns" id="#ppx_ns"></a>

## ppx_ns

<pre>
ppx_ns(<a href="#ppx_ns-name">name</a>, <a href="#ppx_ns-module_name">module_name</a>, <a href="#ppx_ns-msg">msg</a>, <a href="#ppx_ns-ns">ns</a>, <a href="#ppx_ns-ns_sep">ns_sep</a>, <a href="#ppx_ns-opts">opts</a>, <a href="#ppx_ns-submodules">submodules</a>)
</pre>



**ATTRIBUTES** for rule `ppx_ns`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ppx_ns-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ppx_ns-module_name"></a>module_name |  -  | String | optional | "" |
| <a id="ppx_ns-msg"></a>msg |  -  | String | optional | "" |
| <a id="ppx_ns-ns"></a>ns |  -  | String | optional | "" |
| <a id="ppx_ns-ns_sep"></a>ns_sep |  Namespace separator.  Default: '__'  | String | optional | "__" |
| <a id="ppx_ns-opts"></a>opts |  List of OCaml options. Will override configurable default options.  | List of strings | optional | [] |
| <a id="ppx_ns-submodules"></a>submodules |  List of all submodule source files, including .ml/.mli file(s) whose name matches the ns.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |



----

<a name="#ppx_test" id="#ppx_test"></a>

## ppx_test

<pre>
ppx_test(<a href="#ppx_test-name">name</a>, <a href="#ppx_test-cookies">cookies</a>, <a href="#ppx_test-data">data</a>, <a href="#ppx_test-deps">deps</a>, <a href="#ppx_test-expect">expect</a>, <a href="#ppx_test-message">message</a>, <a href="#ppx_test-mode">mode</a>, <a href="#ppx_test-output">output</a>, <a href="#ppx_test-ppx">ppx</a>, <a href="#ppx_test-src">src</a>, <a href="#ppx_test-verbose">verbose</a>)
</pre>



**ATTRIBUTES** for rule `ppx_test`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ppx_test-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ppx_test-cookies"></a>cookies |  Some PPX libs (e.g. foo) take '-cookie' arguments, which must have the form 'name="value"'. Since it is easy to get the quoting wrong due to shell substitutions, this attribute makes it easy. Keys are cookie names, values are cookie vals.  | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: String -> String</a> | optional | {} |
| <a id="ppx_test-data"></a>data |  -  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_test-deps"></a>deps |  -  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ppx_test-expect"></a>expect |  -  | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ppx_test-message"></a>message |  -  | String | optional | "" |
| <a id="ppx_test-mode"></a>mode |  -  | String | optional | "native" |
| <a id="ppx_test-output"></a>output |  Format of output of PPX transform, binary (default) or text  | String | optional | "binary" |
| <a id="ppx_test-ppx"></a>ppx |  -  Providers:   [DefaultInfo](providers_ocaml.md#defaultinfo)  [PpxExecutableProvider](providers_ocaml.md#ppxexecutableprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="ppx_test-src"></a>src |  -  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ppx_test-verbose"></a>verbose |  Adds 'set -x' to the script run by this rule, so the effective command (with substitutions) will be written to the log.  | Boolean | optional | False |



