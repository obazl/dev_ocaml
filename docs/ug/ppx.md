PPX Support
===========

PPX = PreProcessor eXtension.

### attribute: <a name="ppx_print">ppx\_print</a>

PPX executables can emit the AST they produce in binary or text form.

Rules that support PPX processing
([ocaml\_interface](../refman/rules_ocaml.md#ocaml_interface),
[ocaml\_module](../refman/rules_ocaml.md#ocaml_module),
[ppx\_module](../refman/rules_ppx.md#ppx_module)) also support the
`ppx_print` attribute, which controls output format.

The `ppx_print` attribute takes a label, which must be either
`@ppx//print:binary` or `@ppx//print:text`. The former tells OBazl to
add `-dump-ast` as a command line option when running the
`ppx_executable` that is passed by the `ppx` attribute; the latter just
omits the argument.

The default print output format is determined by the [configurable
default](abcd.md) target `@ppx//print`, which in turn defaults to
binary. You can change the global default to print by passing
`--@ppx//print:text` on the command line. Use the `ppx_print` attribute
to override this global default.
