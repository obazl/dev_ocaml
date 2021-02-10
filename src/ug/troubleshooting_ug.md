[User Guide](index.md)

# Troubleshooting

## checklist

* decide on a set of [naming conventions](connventions.md#naming_conventions) and stick to it
* spelling
* capitalization
* dashes and underscores - see [Syntax problems](#syntax) below.
* local (private) [targets]: don't forget the leading colon!
* verify namespace structure:
  * the `ocaml_ns` rule lists all submodule source (.ml) files in its `submodules` attribute
  * each submodule lists the namespace target (`ocaml_ns` instance) in its `ns` attribute
  * if you aggregate the namespace module and submodules in
    `ocaml_archive` or `ocaml_library`, make sure all submodules are
    listed as targets in the `deps` attribute of the aggregator rule.

## <a name="syntax">Syntax problems</a>

```
ERROR: ... syntax error at '=': expected ,
```

This can happen if you mispell and attribute, for example using a dash instead of an underscore.

## unbound module

* This can happen if a .cmi file is missing.  May indicate a bug in the obazl code.

* ocaml_ns: submodules attrib. verify capitalization, e.g. String_with_vars, not String_With_Vars

Example: capitalization in the submodules list, e.g.
        ":_OpamLexer": "Opamlexer",  # not the submod name has incorrect lower-case 'l'

## required module is unavailable

```
File "_none_", line 1:
Error: Required module `Demos_obazl_dune_lang__Atom' is unavailable
```

This is a supremely unhelpful error message. Required by what?

This may mean your dependencies are in the wrong order.

## namespace problems

```
Error: The module String_split is an alias for module Stdune__String_split, which is missing
```

This can happen if you put .ml sources but not their .mli interfaces
into the namespace. Both need to use the `ns` attribute so that they will be available.

## linking problems

Use action graph queries to print a complete description of the
actions - inputs, outputs, command line - of any build target. This is
very fast; it does not execute the actions so it will not actually
build anything.  See [Querying](querying.md) for more information.

## no such target `@opam//pkg:`

This will happen if you depend on an OPAM package but do not list it
in the package list for your switch in `opam.bzl` - see [Packages manifest](bootstrap.md#packages-manifest) and [OPAM Dependencies](dependencies_opam.md).

E.g.

```
no such target '@opam//pkg:ounit2': target 'ounit2' not declared in package 'pkg' defined by /private/var/tmp/_bazel_gar/07858b33091346eb9c40f9f55369f0e5/external/opam/pkg/BUILD.bazel and referenced by '//rules/ocaml_module:_Test'
```

## invalid label

It's easy to forget to double the slash in labels with explicit
workspace names, e.g. writing `@foo/bar:baz` instead of `@foo//bar:baz`.  If you do this you will get an error like the following:

```
 invalid label '@ppx/print:text' in attribute 'ppx_print' in 'ocaml_module' rule: invalid repository name '@ppx/print:text': workspace names may contain only A-Z, a-z, 0-9, '-', '_' and '.'
 ```

## permission denied

```
ERROR: /Users/gar/bazel/obazl/tools_ocaml/obazl/Stdune/BUILD.bazel:37:9: Writing file obazl/Stdune/_obazl_/stdune.ml failed: unexpected I/O exception: /private/var/tmp/_bazel_gar/b616734bcfffe143a5ddb9085fea0452/execroot/demos/bazel-out/darwin-fastbuild/bin/obazl/Stdune/_obazl_/stdune.ml (Permission denied)
```

Run `$ bazel clean` and try again.

## inconsistent assumptions over interface

```
Error: The files bazel-out/darwin-fastbuild/bin/obazl/Stdune/_obazl_/stdune.cmi
       and bazel-out/darwin-fastbuild/bin/obazl/Stdune/_obazl_/Stdune__Dyn.cmi
       make inconsistent assumptions over interface Stdune
```

One possible cause: you've used the same name for namespace module
(i.e. the 'ns' attribute of the ocaml_ns rule) and the ocaml_archive
containing the ns module.  E.g. you have something like:

ocaml_archive( name = "foo", deps = [ ...] )
ocaml_ns( name = "Foo_ns", ns = "foo" ... )

## argument cannot be applied with label

```
File "bazel-out/darwin-fastbuild/bin/obazl/stdune/_obazl_/Stdune__String.ml", line 313, characters 30-31:
313 |   to_seq t |> Seq.filter_map ~f |> of_seq
                                    ^
Error: The function applied to this argument has type
         ('a -> 'b option) -> 'a Seq.t -> unit -> 'b Stdlib__seq.node
This argument cannot be applied with label ~f
```

This may mean that you've got the wrong modules; in particular, that
you need a customized version but you're using the default version.
I.e. you should be using a module that shadows the default provided by
OCaml. In the example above, a custom implementation of `Seq` had been
inadvertently omitted from the deps list.

