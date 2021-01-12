# PPX Support

PPX = PreProcessor eXtension.

## <a name="runtime-deps">Runtime dependencies</a>

## <a id="adjunct_deps" name="adjunct_deps">Adjunct (a/k/a "runtime") dependencies</a>

Sometimes PPX processing injects code that induces compile-time
dependencies; such dependencies must be listed as `deps` in the
`ocaml_module` or `ppx_module` rule that compiles the transformed
source file. These are often called "runtime" dependencies, but OBazl
calls them _adjunct dependencies_, since they are not in fact runtime
dependencies. Runtime dependencies of a module or executable are
needed when that module or executable is executed. These dependencies
do not fit that description.

One way to support adjunct dependencies is to list them in the `deps`
attribute of the `ocaml_module` or `ppx_module` rule instances that
use the PPX executable, as noted above. However this requires
maintenance of the `deps` attribute for each rule instance using the
PPX executable in question. Since PPX executables may be shared by
many targets, this is cumbersome and error-prone.

attribute: **`adjunct_deps`**

As a convenience, OBazl supports an attribute, `adjunct_deps`, on the
`ppx_executable` rule. Dependencies listed in this attribute will be
automatically added the `deps` attribute of any rule that uses the
`ppx_executable` (via the `ppx` attribute) to transform sources.

See
[ocaml_test demo](https://github.com/obazl/dev_obazl/tree/main/demos/rules/ocaml_test) for an example.

## <a name="ppx-attrs">PPX attributes</a>

Rules:  [ocaml_module](../refman/rules_ocaml.md#ocaml_module), [ocaml_interface](../refman/ocaml_rules.md#ocaml_interface), [ppx_module](../refman/rules_ppx.md#ppx_module)

### <a name="ppx">ppx</a>

### <a name="ppx_args">ppx_args</a>

Use `ppx_args` to pass options to the `ppx_executable`.

### <a name="ppx_data">ppx_data</a>

Bazel uses a `data` attribute for runtime file dependencies; OBazl
follows this convention. For rules `ocaml_module`, `ocaml_interface`,
and `ppx_module`, the `data` attribute is for files that will be
needed at runtime.

The `ppx_data` attribute is for files that are needed by the `ppx`
executable when it transforms source files. For example,
[ppx_optcomp]() supports an extension, `import`, that acts like
the `#include` directive of the C preprocessor language: it allows you
to include the content of one file in another. This induces a runtime
dependency: if `foo.ml` contains e.g. `[%import "config.mlh"]`, then
the file `config.mlh` must be available to `ppx_optcomp` when it runs
(as part of the `ppx_executable` tasked with transforming `foo.ml`).
So this is a genuine runtime dependency, and it must be listed in the
`ppx_data` attribute of the `ppx_executable` rule instance that lists
`ppx_optcomp` as a dependency.

See [ppx/ppx_optcomp](https://github.com/obazl/dev_obazl/blob/c0f01d6ae66ecdebbbfac687120ef734886542d4/demos/ppx/ppx_optcomp/BUILD.bazel#L27) for an example.

### <a name="ppx_print">ppx_print</a>

PPX executables can emit the AST they produce in binary or text form.

Rules that support PPX processing
([ocaml_interface](../refman/rules_ocaml.md#ocaml_interface),
[ocaml_module](../refman/rules_ocaml.md#ocaml_module),
[ppx_module](../refman/rules_ppx.md#ppx_module)) also support the
`ppx_print` attribute, which controls output format.

The `ppx_print` attribute takes a label, which must be either
`@ppx//print:binary` or `@ppx//print:text`. The former tells OBazl to
add `-dump-ast` as a command line option when running the
`ppx_executable` that is passed by the `ppx` attribute; the latter
just omits the argument.

The default print output format is determined by the
[configurable_defaults](configurable_defaults.md) target
`@ppx//print`, which in turn defaults to binary. You can change the
global default to print by passing `--@ppx//print:text` on the command
line. Use the `ppx_print` attribute to override this global default.