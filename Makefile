
rules_ocaml:
	bazel build //stardoc:rules_ocaml && sudo cp -v bazel-bin/stardoc/rules_ocaml.adoc docs/rules-ocaml/reference/ocaml-rules.adoc

rules_ocaml_sidebar:
	bazel build //stardoc:rules_ocaml_sidebar && sudo cp -v bazel-bin/stardoc/sidebar_rules_ocaml.yml docs/_data/sidebars/sidebar_rules_ocaml_refman.yml

tools_obazl:
	bazel build //stardoc:tools_obazl && sudo cp -v bazel-bin/stardoc/tools_obazl.adoc docs/tools-obazl/reference/index.adoc

providers:
	bazel build //stardoc:providers_ocaml && sudo cp -v bazel-bin/stardoc/providers_ocaml.adoc docs/rules_ocaml/refman
