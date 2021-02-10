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
* [ocaml_ns_env](#ocaml_ns_env)
* [ocaml_ns_module](#ocaml_ns_module)

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
ocaml_archive(<a href="#ocaml_archive-name">name</a>, <a href="#ocaml_archive-archive_name">archive_name</a>, <a href="#ocaml_archive-cc_deps">cc_deps</a>, <a href="#ocaml_archive-cc_linkall">cc_linkall</a>, <a href="#ocaml_archive-cc_linkopts">cc_linkopts</a>, <a href="#ocaml_archive-deps">deps</a>, <a href="#ocaml_archive-doc">doc</a>, <a href="#ocaml_archive-opts">opts</a>)
</pre>

Generates an OCaml archive file.

**ATTRIBUTES** for rule `ocaml_archive`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_archive-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_archive-archive_name"></a>archive_name |  Name of generated archive file, without extension. Overrides <code>name</code> attribute.  | String | optional | "" |
| <a id="ocaml_archive-cc_deps"></a>cc_deps |  Dictionary specifying C/C++ library dependencies. Key: a target label; value: a linkmode string, which determines which file to link. Valid linkmodes: 'default', 'static', 'dynamic', 'shared' (synonym for 'dynamic'). For more information see [CC Dependencies: Linkmode](../ug/cc_deps.md#linkmode).  Providers:   [CcInfo](providers_ocaml.md#ccinfo) | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_archive-cc_linkall"></a>cc_linkall |  True: use <code>-whole-archive</code> (GCC toolchain) or <code>-force_load</code> (Clang toolchain). Deps in this attribute must also be listed in cc_deps.  Providers:   [CcInfo](providers_ocaml.md#ccinfo) | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_archive-cc_linkopts"></a>cc_linkopts |  List of C/C++ link options. E.g. <code>["-lstd++"]</code>.  | List of strings | optional | [] |
| <a id="ocaml_archive-deps"></a>deps |  List of OCaml dependencies.  Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)  [OcamlImportProvider](providers_ocaml.md#ocamlimportprovider)  [OcamlSignatureProvider](providers_ocaml.md#ocamlsignatureprovider)  [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)  [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)  [OcamlNsArchiveProvider](providers_ocaml.md#ocamlnsarchiveprovider)  [OcamlNsLibraryProvider](providers_ocaml.md#ocamlnslibraryprovider)  [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)  [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_archive-doc"></a>doc |  Deprecated  | String | optional | "" |
| <a id="ocaml_archive-opts"></a>opts |  List of OCaml options. Will override configurable default options.  | List of strings | optional | [] |



----

<a name="#ocaml_executable" id="#ocaml_executable"></a>

## ocaml_executable

<pre>
ocaml_executable(<a href="#ocaml_executable-name">name</a>, <a href="#ocaml_executable-cc_deps">cc_deps</a>, <a href="#ocaml_executable-cc_linkall">cc_linkall</a>, <a href="#ocaml_executable-cc_linkopts">cc_linkopts</a>, <a href="#ocaml_executable-data">data</a>, <a href="#ocaml_executable-deps">deps</a>, <a href="#ocaml_executable-deps_adjunct">deps_adjunct</a>,
                 <a href="#ocaml_executable-deps_adjunct_opam">deps_adjunct_opam</a>, <a href="#ocaml_executable-deps_opam">deps_opam</a>, <a href="#ocaml_executable-main">main</a>, <a href="#ocaml_executable-message">message</a>, <a href="#ocaml_executable-opts">opts</a>, <a href="#ocaml_executable-strip_data_prefixes">strip_data_prefixes</a>)
</pre>

Generates an OCaml executable binary. Provides only standard DefaultInfo provider.

**CONFIGURABLE DEFAULTS** for rule `ocaml_executable`

In addition to the [OCaml configurable defaults](#configdefs) that apply to all
`ocaml_*` rules, the following apply to this rule:

| Label | Default | `opts` attrib |
| ----- | ------- | ------- |
| @ocaml//executable:linkall | True | `-linkall`, `-no-linkall`|
| @ocaml//executable:thread | True | `-thread`, `-no-thread`|
| @ocaml//executable:warnings | `@1..3@5..28@30..39@43@46..47@49..57@61..62-40`| `-w` plus option value |

**NOTE** These do not support `:enable`, `:disable` syntax.

 See [Configurable Defaults](../ug/configdefs_doc.md) for more information.
    

**ATTRIBUTES** for rule `ocaml_executable`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_executable-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_executable-cc_deps"></a>cc_deps |  Dictionary specifying C/C++ library dependencies. Key: a target label; value: a linkmode string, which determines which file to link. Valid linkmodes: 'default', 'static', 'dynamic', 'shared' (synonym for 'dynamic'). For more information see [CC Dependencies: Linkmode](../ug/cc_deps.md#linkmode).  | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_executable-cc_linkall"></a>cc_linkall |  True: use <code>-whole-archive</code> (GCC toolchain) or <code>-force_load</code> (Clang toolchain). Deps in this attribute must also be listed in cc_deps.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-cc_linkopts"></a>cc_linkopts |  List of C/C++ link options. E.g. <code>["-lstd++"]</code>.  | List of strings | optional | [] |
| <a id="ocaml_executable-data"></a>data |  Runtime dependencies: list of labels of data files needed by this executable at runtime.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-deps"></a>deps |  List of OCaml dependencies.  Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)  [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)  [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)  [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)  [OcamlNsArchiveProvider](providers_ocaml.md#ocamlnsarchiveprovider)  [OcamlNsLibraryProvider](providers_ocaml.md#ocamlnslibraryprovider)  [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider)  [CcInfo](providers_ocaml.md#ccinfo) | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-deps_adjunct"></a>deps_adjunct |  List of non-opam adjunct dependencies (labels).  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_executable-deps_adjunct_opam"></a>deps_adjunct_opam |  List of opam adjunct dependencies (pkg name strings).  | List of strings | optional | [] |
| <a id="ocaml_executable-deps_opam"></a>deps_opam |  List of OPAM package names  | List of strings | optional | [] |
| <a id="ocaml_executable-main"></a>main |  Label of module containing entry point of executable. This module will be placed last in the list of dependencies.  Providers:   [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)  [PpxModuleProvider](providers_ocaml.md#ppxmoduleprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_executable-message"></a>message |  Deprecated  | String | optional | "" |
| <a id="ocaml_executable-opts"></a>opts |  List of OCaml options. Will override configurable default options.  | List of strings | optional | [] |
| <a id="ocaml_executable-strip_data_prefixes"></a>strip_data_prefixes |  Symlink each data file to the basename part in the runfiles root directory. E.g. test/foo.data -&gt; foo.data.  | Boolean | optional | False |



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
| <a id="ocaml_import-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |



----

<a name="#ocaml_library" id="#ocaml_library"></a>

## ocaml_library

<pre>
ocaml_library(<a href="#ocaml_library-name">name</a>, <a href="#ocaml_library-deps">deps</a>, <a href="#ocaml_library-msg">msg</a>, <a href="#ocaml_library-srcs">srcs</a>)
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
    

**ATTRIBUTES** for rule `ocaml_library`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_library-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_library-deps"></a>deps |  List of OCaml dependencies.  Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)  [OcamlImportProvider](providers_ocaml.md#ocamlimportprovider)  [OcamlSignatureProvider](providers_ocaml.md#ocamlsignatureprovider)  [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)  [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)  [OcamlNsArchiveProvider](providers_ocaml.md#ocamlnsarchiveprovider)  [OcamlNsLibraryProvider](providers_ocaml.md#ocamlnslibraryprovider)  [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)  [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_library-msg"></a>msg |  DEPRECATED  | String | optional | "" |
| <a id="ocaml_library-srcs"></a>srcs |  -  Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)  [OcamlImportProvider](providers_ocaml.md#ocamlimportprovider)  [OcamlSignatureProvider](providers_ocaml.md#ocamlsignatureprovider)  [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)  [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)  [OcamlNsLibraryProvider](providers_ocaml.md#ocamlnslibraryprovider)  [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)  [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |



----

<a name="#ocaml_module" id="#ocaml_module"></a>

## ocaml_module

<pre>
ocaml_module(<a href="#ocaml_module-name">name</a>, <a href="#ocaml_module-cc_deps">cc_deps</a>, <a href="#ocaml_module-data">data</a>, <a href="#ocaml_module-deps">deps</a>, <a href="#ocaml_module-deps_opam">deps_opam</a>, <a href="#ocaml_module-doc">doc</a>, <a href="#ocaml_module-msg">msg</a>, <a href="#ocaml_module-ns_env">ns_env</a>, <a href="#ocaml_module-opts">opts</a>, <a href="#ocaml_module-ppx">ppx</a>, <a href="#ocaml_module-ppx_args">ppx_args</a>, <a href="#ocaml_module-ppx_data">ppx_data</a>,
             <a href="#ocaml_module-ppx_print">ppx_print</a>, <a href="#ocaml_module-ppx_tags">ppx_tags</a>, <a href="#ocaml_module-sig">sig</a>, <a href="#ocaml_module-struct">struct</a>)
</pre>

Compiles an OCaml module. Provides: [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider).

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
| @ocaml//module:thread  | True | `-thread`, `-no-thread`|
| @ocaml//module:verbose | True | `-verbose`, `-no-verbose`|

**NOTE** These do not support `:enable`, `:disable` syntax.

 See [Configurable Defaults](../ug/configdefs_doc.md) for more information.
    

**ATTRIBUTES** for rule `ocaml_module`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_module-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_module-cc_deps"></a>cc_deps |  Dictionary specifying C/C++ library dependencies. Key: a target label; value: a linkmode string, which determines which file to link. Valid linkmodes: 'default', 'static', 'dynamic', 'shared' (synonym for 'dynamic'). For more information see [CC Dependencies: Linkmode](../ug/cc_deps.md#linkmode).  | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |
| <a id="ocaml_module-data"></a>data |  Runtime dependencies: list of labels of data files needed by this module at runtime.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_module-deps"></a>deps |  List of OCaml dependencies.  Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)  [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)  [OcamlImportProvider](providers_ocaml.md#ocamlimportprovider)  [OcamlSignatureProvider](providers_ocaml.md#ocamlsignatureprovider)  [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)  [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)  [OcamlNsArchiveProvider](providers_ocaml.md#ocamlnsarchiveprovider)  [OcamlNsLibraryProvider](providers_ocaml.md#ocamlnslibraryprovider)  [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider)  [PpxModuleProvider](providers_ocaml.md#ppxmoduleprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_module-deps_opam"></a>deps_opam |  List of OPAM package names  | List of strings | optional | [] |
| <a id="ocaml_module-doc"></a>doc |  Docstring for module. DEPRECATED  | String | optional | "" |
| <a id="ocaml_module-msg"></a>msg |  -  | String | optional | "" |
| <a id="ocaml_module-ns_env"></a>ns_env |  Label of an ocaml_ns_env target. Used for renaming struct source file. See [Namepaces](../namespaces.md) for more information.  Providers:   [OcamlNsEnvProvider](providers_ocaml.md#ocamlnsenvprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_module-opts"></a>opts |  List of OCaml options. Will override configurable default options.  | List of strings | optional | [] |
| <a id="ocaml_module-ppx"></a>ppx |  PPX binary (executable).  The rule will use this executable to transform the source file before compiling it. For more information on the actions generated by <code>ocaml_module</code> when used with a PPX transform see [Action Queries](../ug/transparency.md#action_queries).  Providers:   [PpxExecutableProvider](providers_ocaml.md#ppxexecutableprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_module-ppx_args"></a>ppx_args |  Options to pass to PPX binary passed by the <code>ppx</code> attribute.  | List of strings | optional | [] |
| <a id="ocaml_module-ppx_data"></a>ppx_data |  PPX runtime dependencies. List of labels of files needed by the PPX executable passed via the <code>ppx</code> attribute when it is executed to transform the source file. For example, a source file using [ppx_optcomp](https://github.com/janestreet/ppx_optcomp) may import a file using extension <code>[%%import ]</code>; this file should be listed in this attribute.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_module-ppx_print"></a>ppx_print |  Format of output of PPX transform. Value must be one of '@ppx//print:binary', '@ppx//print:text'.  See [PPX Support](../ug/ppx.md#ppx_print) for more information  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @ppx//print:binary |
| <a id="ocaml_module-ppx_tags"></a>ppx_tags |  DEPRECATED. List of tags.  Used to set e.g. -inline-test-libs, --cookies. Currently only one tag allowed.  | List of strings | optional | [] |
| <a id="ocaml_module-sig"></a>sig |  Single label of a target providing a single .cmi or .mli file. Optional. Currently only supports .cmi input.  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_module-struct"></a>struct |  A single .ml source file label.  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |



----

<a name="#ocaml_ns_env" id="#ocaml_ns_env"></a>

## ocaml_ns_env

<pre>
ocaml_ns_env(<a href="#ocaml_ns_env-name">name</a>, <a href="#ocaml_ns_env-aliases">aliases</a>, <a href="#ocaml_ns_env-opts">opts</a>, <a href="#ocaml_ns_env-prefix">prefix</a>, <a href="#ocaml_ns_env-resolver">resolver</a>, <a href="#ocaml_ns_env-sep">sep</a>)
</pre>

This rule initializes a 'namespace evaluation environment' consisting of a pseudo-namespace prefix string and optionally an ns resolver module.  A pseudo-namespace prefix string is a string that is used to form (by prefixation) a (presumably) globally unique name for a module. An ns resolver module is a module that contains nothing but alias equations mapping module names to pseudo-namespaced module names.

You may use the [ns_env](macros.md#ns_env) macro instead of instantiating this rule directly.

This rule is designed to work in conjujnction with rules
[ocaml_module](rules_ocaml.md#ocaml_module) and
[ocaml_ns_module](rules_ocaml.md#ocaml_ns_module). An `ocaml_module`
instance can use the prefix string of an `ocaml_ns_env` to rename its
source file by using attribute `ns` to reference the label of an
`ocaml_ns_env` target. Instances of `ocaml_ns_module` can list such
modules as `submodule` dependencies. They can also use an
`ocaml_ns_env` prefix string to name themselves, by using their `ns`
attribute similarly. This allows ns modules to be (pseudo-)namespaced in the
same way submodules are namespaced.

The prefix string defaults to the (Bazel) package name string, with
each segment capitalized and the path separator ('/') replaced by the
`sep` string (default: `_`). If you pass a prefix string it must be a
legal OCaml module path; each segment will be capitalized and the segment
separator ('.') will be replaced by the `sep` string. The resulting
prefix may be used by `ocaml_module` rules (via the `ns` attribute) to
rename their source files, and, if `module = True`, by this rule to
generate alias equations.

For example, if package `//alpha/beta/gamma` contains`foo.ml`:

```
ns_env() => Alpha_Beta_Gamma__foo.ml
ns_env(sep="") => AlphaBetaGamma__foo.ml
ns_env(sep="__") => Alpha__Beta__Gamma__foo.ml
ns_env(prefix="foo.bar") => Foo_Bar__foo.ml (pkg path ignored)
ns_env(prefix="foo.bar", sep="") => FooBar__foo.ml
```


The optional ns resolver module will be named `<prefix>__00.ml`; since
`0` is not a legal initial character for an OCaml module name, this
ensures it will never clash with a user-defined module.

The ns resolver module will contain alias equations mapping module
names derived from the `srcs` list to pseudo-namespaced module names
(and thus indirectly filenames). For example, if `srcs` contains
`foo.ml`, and the prefix is `a.b`, then the resolver module will
contain `module Foo = A_b_foo`.

Submodule file names will be formed by prefixing the pseudo-ns prefix to the (original, un-namespaced) module name, separated by 'sep' (default: '__'). For example, if the prefix is 'Foo_bar' and the module is 'baz.ml', the submodule file name will be 'Foo_bar__baz.ml'.

The main namespace module will contain aliasing equations that map module names to these prefixed module names.

By default, the ns prefix string is formed from the package name, with '/' replaced by '_'. You can use the 'ns' attribute to change this:

ns(ns = "foobar", srcs = glob(["*.ml"]))

    

**ATTRIBUTES** for rule `ocaml_ns_env`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_ns_env-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_ns_env-aliases"></a>aliases |  List of files from which submodule names are to be derived for aliasing. The names will be formed by truncating the extension and capitalizing the initial character. Module source code generated by ocamllex and ocamlyacc can be accomodated by using the module name for the source file and generating a .ml source file of the same name, e.g. lexer.mll -&gt; lexer.ml.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |
| <a id="ocaml_ns_env-opts"></a>opts |  List of OCaml options. Will override configurable default options.  | List of strings | optional | [] |
| <a id="ocaml_ns_env-prefix"></a>prefix |  Defaults to package name with '/' replaced by underscore <code>\_</code>. Use this attribute to set it to some other string. Must be a legal OCaml module path; dots <code>.</code> will be converted to <code>sep</code> string.  | String | optional | "" |
| <a id="ocaml_ns_env-resolver"></a>resolver |  Determines whether ns resolver module is generated. If True, then <code>srcs</code> attribute must not be empty. Must be true if submodules are inter-dependent.  | Boolean | optional | False |
| <a id="ocaml_ns_env-sep"></a>sep |  String used to replace segment separator ('.') in prefix string.  | String | optional | "_" |



----

<a name="#ocaml_ns_library" id="#ocaml_ns_library"></a>

## ocaml_ns_library

<pre>
ocaml_ns_library(<a href="#ocaml_ns_library-name">name</a>, <a href="#ocaml_ns_library-archive">archive</a>, <a href="#ocaml_ns_library-includes">includes</a>, <a href="#ocaml_ns_library-main">main</a>, <a href="#ocaml_ns_library-ns_env">ns_env</a>, <a href="#ocaml_ns_library-opts">opts</a>, <a href="#ocaml_ns_library-submodules">submodules</a>)
</pre>

Generate a 'namespace' module. [User Guide](../ug/ocaml_ns.md).  Provides: [OcamlNsLibraryProvider](providers_ocaml.md#ocamlnsmoduleprovider).

**NOTE** 'name' must be a legal OCaml module name string.  Leading underscore is illegal.

See [Namespacing](../ug/namespacing.md) for more information on namespaces.

    

**ATTRIBUTES** for rule `ocaml_ns_library`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_ns_library-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_ns_library-archive"></a>archive |  Output and archive file containing this namespace module and all submodules.  | Boolean | optional | False |
| <a id="ocaml_ns_library-includes"></a>includes |  List of modules to be 'include'd in the resolver.  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_ns_library-main"></a>main |  Code to use as the ns module instead of generated code. The module specified must contain pseudo-recursive alias equations for all submodules.  If this attribute is specified, an ns resolver module will be generated for resolving the alias equations of the provided module.  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_ns_library-ns_env"></a>ns_env |  Label of an ocaml_ns_env target. Used for renaming struct source file. See [Namepaces](../namespaces.md) for more information.  Providers:   [OcamlNsEnvProvider](providers_ocaml.md#ocamlnsenvprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_ns_library-opts"></a>opts |  List of OCaml options. Will override configurable default options.  | List of strings | optional | [] |
| <a id="ocaml_ns_library-submodules"></a>submodules |  Dict from submodule target to name  Providers:   [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider)  [OcamlNsArchiveProvider](providers_ocaml.md#ocamlnsarchiveprovider)  [OcamlNsLibraryProvider](providers_ocaml.md#ocamlnslibraryprovider)  [OcamlSignatureProvider](providers_ocaml.md#ocamlsignatureprovider) | <a href="https://bazel.build/docs/skylark/lib/dict.html">Dictionary: Label -> String</a> | optional | {} |



----

<a name="#ocaml_signature" id="#ocaml_signature"></a>

## ocaml_signature

<pre>
ocaml_signature(<a href="#ocaml_signature-name">name</a>, <a href="#ocaml_signature-deps">deps</a>, <a href="#ocaml_signature-deps_opam">deps_opam</a>, <a href="#ocaml_signature-msg">msg</a>, <a href="#ocaml_signature-ns_env">ns_env</a>, <a href="#ocaml_signature-opts">opts</a>, <a href="#ocaml_signature-ppx">ppx</a>, <a href="#ocaml_signature-ppx_args">ppx_args</a>, <a href="#ocaml_signature-ppx_data">ppx_data</a>, <a href="#ocaml_signature-ppx_print">ppx_print</a>, <a href="#ocaml_signature-src">src</a>)
</pre>

Generates OCaml .cmi (inteface) file. [User Guide](../ug/ocaml_signature.md). Provides `OcamlSignatureProvider`.

**CONFIGURABLE DEFAULTS** for rule `ocaml_executable`

In addition to the [OCaml configurable defaults](#configdefs) that apply to all
`ocaml_*` rules, the following apply to this rule:

| Label | Default | `opts` attrib |
| ----- | ------- | ------- |
| @ocaml//interface:linkall | True | `-linkall`, `-no-linkall`|
| @ocaml//interface:thread | True | `-thread`, `-no-thread`|
| @ocaml//interface:warnings | `@1..3@5..28@30..39@43@46..47@49..57@61..62-40`| `-w` plus option value |

**NOTE** These do not support `:enable`, `:disable` syntax.

 See [Configurable Defaults](../ug/configdefs_doc.md) for more information.
    

**ATTRIBUTES** for rule `ocaml_signature`

| Name  | Description | Type | Mandatory | Default |
| ------------- | ------------- | ------------- | :------------- | :------------- |
| <a id="ocaml_signature-name"></a>name |  A unique name for this target.  | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="ocaml_signature-deps"></a>deps |  List of OCaml dependencies. See [Dependencies](#deps) for details.  Providers:   [OpamPkgInfo](providers_ocaml.md#opampkginfo)  [OcamlArchiveProvider](providers_ocaml.md#ocamlarchiveprovider)  [OcamlSignatureProvider](providers_ocaml.md#ocamlsignatureprovider)  [OcamlLibraryProvider](providers_ocaml.md#ocamllibraryprovider)  [OcamlNsLibraryProvider](providers_ocaml.md#ocamlnslibraryprovider)  [PpxArchiveProvider](providers_ocaml.md#ppxarchiveprovider)  [OcamlModuleProvider](providers_ocaml.md#ocamlmoduleprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_signature-deps_opam"></a>deps_opam |  List of OPAM package names  | List of strings | optional | [] |
| <a id="ocaml_signature-msg"></a>msg |  Deprecated  | String | optional | "" |
| <a id="ocaml_signature-ns_env"></a>ns_env |  Label of an ocaml_ns_env target. Used for renaming struct source file. See [Namepaces](../namespaces.md) for more information.  Providers:   [OcamlNsEnvProvider](providers_ocaml.md#ocamlnsenvprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_signature-opts"></a>opts |  List of OCaml options. Will override configurable default options.  | List of strings | optional | [] |
| <a id="ocaml_signature-ppx"></a>ppx |  Label of <code>ppx_executable</code> target to be used to transform source before compilation.  Providers:   [PpxExecutableProvider](providers_ocaml.md#ppxexecutableprovider) | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="ocaml_signature-ppx_args"></a>ppx_args |  Options to pass to PPX executable.  | List of strings | optional | [] |
| <a id="ocaml_signature-ppx_data"></a>ppx_data |  PPX runtime dependencies. List of labels of files needed by PPX at preprocessing runtime. E.g. a file used by <code>[%%import ]</code> from [ppx_optcomp](https://github.com/janestreet/ppx_optcomp).  | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="ocaml_signature-ppx_print"></a>ppx_print |  Format of output of PPX transform. Value must be one of '@ppx//print:binary', '@ppx//print:text'. See [PPX: ppx_print](../ug/ppx.md#ppx_print) for more information.  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | @ppx//print:binary |
| <a id="ocaml_signature-src"></a>src |  A single .mli source file label  | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |



