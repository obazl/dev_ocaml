# Configurable Defaults

Some OCaml compile options are used so commonly that they should
probably be the default. Changing compiler defaults would break
existing code, so OBazl does the next best thing: it defines a set of
_configurable default_ flags and options that control the construction
of compile commands.


Case-by-case overrides
----------------------

For example, verbosity is globally disabled by default. To enable
verbosity for a particular `ocaml_module` instance, just add
`-verbose` to the `opts` attribute of the rule.

