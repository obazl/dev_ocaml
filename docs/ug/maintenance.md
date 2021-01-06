maintenance
===========

-   [Tasks](#tasks)
    -   [File edits](#fileedits)
-   [Batch Editing](#batch)
    -   [Patching](#patching)
-   [Case study](#case)

<a name="tasks">Tasks</a>
-------------------------

### <a name="fileedits">File edits</a>

Changes to source files do not affect build logic, *unless* they involve
dependencies. If you add or remove a dependency, you should edit the
`BUILD.bazel` file accordingly.

**OCaml Dependencies**

Dependencies expressed in the build file that are not in fact used by
the source code do not break the build, but do make it inefficient. Two
tools are available to check OCaml dependencies:

-   [ocamldep](https://caml.inria.fr/pub/docs/manual-ocaml/depend.html)
    the legacy tool; and
-   [codept](https://opam.ocaml.org/packages/codept/), a more powerful
    dependency solver.

**Runtime Dependencies**

Source files that access the filesystem (e.g. by reading a data file)
may have *runtime dependencies*. These should be listed in the `data`
attribute.

**PPX Dependencies**

PPX extensions may involve file reads; for example,
[ppx\_optcomp](https://github.com/janestreet/ppx_optcomp) supports an
`[@@import` *filename*`]` extension.

<a name="batch">Batch Editing</a>
---------------------------------

The
[buildozer](https://github.com/bazelbuild/buildtools/blob/master/buildozer/README.md)
tool makes it easy to batch edit build files. You can:

-   add or delete rules
-   add, remove, or rename attributes
-   add, remove, or change attribute values
-   edit `load` statements
-   add or remove comments
-   apply edits to a filtered selection of build packages/targets
-   and much, much more!

Bazel's query facilities
([query](https://docs.bazel.build/versions/master/query.html),
[cquery](https://docs.bazel.build/versions/master/cquery.html),
[aquery](https://docs.bazel.build/versions/master/aquery.html)) make it
easy to inspect the build structure of your project, so that you can
decide how to structure your `buildozer` commands.

To ensure that your `buildozer` commands are correct, you can first use
its `print` subcommand to get an idea of how it analyzes your code.
However, `buildozer` does not evaluate build files, it only works at the
syntactic level. To get a better picture of the structure, you can use
Bazel's [query](https://docs.bazel.build/versions/master/query.html)
facility.

Examples:

-   Use `buildozer` to print occurances of attribute `opts` for all
    `ocaml_ns` rules in all packages under `src/`:

``` {.shell}
$ buildozer 'print label opts' src/...:%ocaml_ns
rule "//mina/gitfork/src/...:Logproc_lib_ns" has no attribute "opts"
rule "//mina/gitfork/src/...:Interpolator_lib_ns" has no attribute "opts"
...
//mina/gitfork/src/...:Snark_work_lib_ns []
//mina/gitfork/src/...:Pokolog_ns []
...
```

Notice that 1) the output shows the file system path (the command was
run from `$HOME/mina/gitfork`), and 2) it does not show the full package
label. To get a fuller picture, use the query facility:

``` {.shell}
$ bazel query 'attr(opts, ".*", kind("ocaml_ns", //src/...:all))'
ocaml_ns rule //src/nonconsensus/unsigned_extended:Unsigned_extended_nonconsensus_ns
ocaml_ns rule //src/nonconsensus/snark_bits:Snark_bits_nonconsensus_ns
...
```

-   Remove `opts` attribute from all `ocaml_ns` rules in package
    `//src/lib/transition_frontier`.

``` {.shell}
$ buildozer 'remove opts' src/lib/transition_frontier/...:*
```

    To remove it from all packages

``` {.shell}
$ buildozer 'remove opts' src/...:%ocaml_ns
```

### <a name="patching">Patching</a>

Buildozer can read its commands from a file. Since commands can be
fine-grained (e.g. applied to a single target in a single package),
`buildozer` can be used to implement a kind of patching facility.

For example, suppose you use a tool to automatically generate your build
files. A typical case would be where you support both Dune and OBazl
builds, and you generate Bazel build files from Dune files.

There may be cases where the generated files need to be tuned in some
manner, such as adding option values like "-w -24", or adding a
dependency that your conversion tool cannot discover. In such cases you
can write a `buildozer` edit command to automated the editing. You would
run the `buildozer` commands every time you update your build files
using the conversion tool.

<a name="case">Case study: removing an attribute from rule instances</a>
------------------------------------------------------------------------

The initial version of rule `ocaml_ns` included an `opts` attribute that
is not needed. Removing it from the rule entailed editing existing
projects to remove it from instances of the rule. The
[buildozer](#buildozer) tool makes this easy.

**Step one**: verify that all occurances of `opts` on `ocaml_ns` rules
are empty. This was not strictly necessary, since the rule did not use
the attribute anyway, but we show it for demonstration purposes. The
first query below will print all instances whose `opts` attribute is
empty, or contains a null string, or a string of spaces; the second will
print any instances whose `opts` attribute is not empty:

``` {.shell}
$ bazel query 'attr(opts, "\[ *]", kind("ocaml_ns", //src/...:all))' | sort
$ bazel query 'attr(opts, "\[.*[^ ].*\]", kind("ocaml_ns", //src/...:all))' | sort
```

Note that the second argument to the `attr` function is a regular
expression used to match the content of the `opts` attribute; see
[attr](https://docs.bazel.build/versions/master/query.html#attr) for
more information on querying attributes.

**Step two**: remove the attribute:

``` {.shell}
$ buildozer 'remove opts' src/...:%ocaml_ns
fixed /Users/gar/mina/gitfork/src/lib/otp_lib/BUILD.bazel
fixed /Users/gar/mina/gitfork/src/lib/pickles/limb_vector/BUILD.bazel
...
```

**Step three**: verify results. Using `buildozer`:

``` {.shell}
$ buildozer 'print label opts' src/...:%ocaml_ns | sort
rule "//mina/gitfork/src/...:Non_zero_curve_point_ns" has no attribute "opts"
rule "//mina/gitfork/src/...:Tweedle_ns" has no attribute "opts"
...
```

Using `query`: this is a little bit trickier, since the query facility
looks at rule definitions as well as instances, unlike `buildozer`. The
`attr` function we used above will treat every instance of `ocaml_ns` as
containing an `opts` attribute even if it is not explicity expressed by
the instance code, since it is defined for the rule and therefore has a
default value. So if we run the query we ran previously after removal of
the `opts` attribute from the `BUILD.bazel` files but before its removal
from the rule definition, we get a list of all the `ocaml_ns` instances.
But if we run it after the rule definition has been changed, then,
assuming our remove command succeeded, it will produce the empty list,
verifying our `buildozer` edit. On the other hand, if an `ocaml_ns`
instance has an `opts` attribute, running the query will throw an
exception complaining that the rule has no `opts` attribute. So strictly
speaking we do not need to run this query, we can just run a build.

``` {.shell}
$ bazel query 'attr(opts, ".*", kind("ocaml_ns", //src/...:all))' | sort
```

(Note: we changed the regex to match anything, since we just want to
know if the attribute exists.)
