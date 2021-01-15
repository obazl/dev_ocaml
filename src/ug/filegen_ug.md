[User Guide](index.md)

# File Generation

Generating files is easy in Bazel. No Obazl-specific rules are needed
to generate files and integrate them into your OCaml build. There are
two techniques you can use: [genrule](#genrule) and a custom [template rule](#template).

## <a name="genrule">genrule</a>

Rule [genrule](https://docs.bazel.build/versions/master/be/general.html#genrule)
(for "general rule") provides a means of integrating
shell scripts into Bazel's hermitic build ecosystem. In addition to
passing the script via the `cmd` attribute, you must pass all inputs
(files and tools) and outputs, in accordance with the general Bazel
requirement. That's what allows Bazel to add your script to the
dependency graph, so as to ensure a reproducible build.

Example from [demos/ppx/genrule](https://github.com/obazl/dev_obazl/tree/main/demos/ppx/genrule):

```
genrule(
    name = "transform",
    srcs = ["hello.ml"],
    ## due to filename->module_name rules, output must be hello.ml, not e.g. hello.pp.ml
    outs = ["tmp/hello.ml"],
    tools = [":_ppx.exe"],
    ## $(location :_ppx.exe) resolves to wherever Bazel placed _ppx.exe.
    ## $< is the input file; $@ is the output file.
    cmd = "$(location :_ppx.exe) -dump-ast $< > $@"
)
```

This `genrule` runs a PPX executable (`:_ppx.exe') to transform input
`hello.ml`, placing the output in `tmp/hello.ml`. The `":_ppx.exe"`
label refers to the `ppx_executable` target that produces the
executable; `$(location :ppx.exe)` is a Bazel-specific construct that
resolves to the file-system location of the file produced by
`:_ppx.exe` (which could be anywhere).

Emitting multiple files is a little more complicated. See the
[genrule documentation](https://docs.bazel.build/versions/master/be/general.html#genrule)
for more information.

>    **IMPORTANT** To depend on a file produced by `genrule`, you can use
>    the label of the `outs` file.  You do not have to use the name of the rule.

## <a name="template">Custom template rules</a>

Bazel supports a rudimentary templating functionality via the
[expand_template](https://docs.bazel.build/versions/master/skylark/lib/actions.html#expand_template)
action. To use this you must write a custom rule; fortunately that is
not terribly difficult to do. Describing how is beyond the scope of
this manual, but you can find a simple example with extensive comments at
[demos/filegen/template](https://github.com/obazl/dev_obazl/tree/main/demos/filegen/template).