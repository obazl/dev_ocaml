# docs_obazl

Online at [https://obazl.github.io/docs_obazl/](https://obazl.github.io/docs_obazl/)

DOCUMENTATION, demos, and tools for obazl_rules_ocaml and obazl_rules_opam.

**WARNING** Stardoc is broken, it won't parse code that works with
bazel build. This affects some of our documentation (ocaml_archive, ocaml_module, ocaml_signature).

## Asciidoc (User Guides)

Edit directly in `docs/rules_ocaml` and `docs/tools_opam`.

To test:  changedir to `docs/`, then `$ bundle exec jekyll serve`

Site is at `localhost:4000`

## Stardoc (Reference Manuals)

`$ bazel build //stardoc/rules_ocaml`

Then copy bazel-bin/stardoc/rules_ocaml.adoc to docs/rules_ocaml/refman

OUTDATED:

To generate the documentation:

* Edit `src`, not `docs`

* Run `$ bazel build src/...:*`

NOTE: the asterisk may annoy some shells; in the case escape it: `\*'.

**WARNING** no need to use pandoc, just copy srcs to the docs dir

`$ sudo cp src/ug/*adoc docs/ug`
`$ sudo cp src/refman/*adoc docs/refman`

OBSOLETE:

Or `$ bazel build src/ug:<tgt>` etc.

* Copy the output to `docs`:

  * `sudo cp bazel-out/darwin-fastbuild/bin/src/*md docs/`
  * `sudo cp bazel-out/darwin-fastbuild/bin/src/ug/*md docs/ug`
  * `sudo cp bazel-out/darwin-fastbuild/bin/src/refman/*md docs/refman`

## updating rule docs

The stardoc rules that generate detailed docs are in
`refman/BUILD.bazel`, target `rules_ocaml`.

1. Overviews and indices are in the files listed in the
   `header_template` attribute of the stardoc rule, and are found in
   `templates/markdown`. E.g. the header for ocaml rules is
   `templates/markdown/header_rules_ocaml.vm`. If you
   add/change/delete a rule name, you need to edit the header.

2. The `input` attrib of the the `rules_ocaml` stardoc target is the
   same extension file applications use to import rules; it exports
   the publicly available rule names.

3. Documentation is generated only for the rules listed in the
   `symbol_names` attribute of the stardoc rule, so the index must be
   (manually) kept in sync with this list.

