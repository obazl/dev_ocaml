# docs_obazl
=======

Documentation, demos, and tools for obazl_rules_ocaml and obazl_rules_opam.

To generate the documentation:

* Edit `src`, not `docs`

* Run `$ bazel build src/...:*`

* Copy the output to `docs`:

  * `sudo cp bazel-out/darwin-fastbuild/bin/src/*md docs/`
  * `sudo cp bazel-out/darwin-fastbuild/bin/src/ug/*md docs/ug`
  * `sudo cp bazel-out/darwin-fastbuild/bin/src/refman/*md docs/refman`
