# PPX Support

PPX = PreProcessor eXtension.

## <a name="main_module">Main Module</a>

Unlike many compiled languages, OCaml does not define a `main` entry
point for executables. The modules used to construct an executable are
organized in the executable binary in the order in which they were
passed as arguments to the compiler. When control is passed to an
OCaml executable, the (top-level) code of the component modules is
executed in order.

This means it is possible to successfully compile and run an OCaml
executable that lacks critical modules. Since there is no `main` entry
point, the compiler has no way of knowing that something is missing.

The `main` attribute of the `ppx_executable` rule is a convenience
attribute, intended to make it harder to build a PPX executable that
is missing the critical piece of code that drives PPX processing. A
module passed as `main` will automatically be added as the last module
in the dependency list, thereby ensuring that it will receive control
after all other modules.

Demo code:  [demos/ppx/hello](https://github.com/obazl/dev_obazl/blob/aed0ce898b480c109ccd9b42fddc6f6c1640277c/demos/ppx/hello/BUILD.bazel#L53)

### The Ppxlib Driver module

Here is one way to implement a driver for a `ppx_executable`:

```
ppx_executable( name = "_ppx.exe", main = ":_Driver", ...etc... )
ppx_module(
    name = "_Driver",
    src = ":ppxlib_driver.ml",
    deps = ["@opam//pkg:ppxlib"],
)
genrule(
    name = "gendriver",
    outs = ["ppxlib_driver.ml"],
    cmd = "\n".join([
        "echo \"(* GENERATED FILE - DO NOT EDIT *)\" > \"$@\"",
        "echo \"let () = Ppxlib.Driver.standalone ()\" >> \"$@\"",
    ]),
)
```

## <a name="runtime-deps">Runtime dependencies</a>

Runtime dependencies are files that are required by modules and/or
executables at runtime. For non-PPX modules and executables, such
files must be passed using the `data` attribute; for PPX modules and
executables, they must be passed using the `ppx_data` attribute, as
[described below](#ppx_data).
The rules will arrange for the files to be included in the generated
command line with the appropriate option flags.

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

----
## <a name="ppx-attrs">PPX attributes</a>

These attributes apply to rules [ocaml_module](../refman/rules_ocaml.md#ocaml_module), [ocaml_interface](../refman/ocaml_rules.md#ocaml_interface), [ppx_module](../refman/rules_ppx.md#ppx_module).

Attributes applicable to `ppx_*` rules are documented in the [Reference Manual](../refman/rules_ppx.md)

### <a name="ppx">ppx</a>

The `ppx` attribute takes a `ppx_executable` target. The rule will
generate several actions - see [Action Queries](transparency.md#action_queries)
to see how to inspect the actions.

### <a name="ppx_args">ppx_args</a>

Use `ppx_args` to pass options to the `ppx_executable` that is passed via the `ppx` attribute.

### <a name="ppx_data">ppx_data</a>

Bazel uses a `data` attribute for runtime file dependencies; OBazl
follows this convention. For rules `ocaml_executable`, `ocaml_module`,
`ocaml_interface`, `ppx_executable`, and `ppx_module`, the `data`
attribute is for files that will be needed at runtime.

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