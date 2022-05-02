
rules_ocaml:
	bazel build //stardoc:rules_ocaml && sudo cp -v bazel-bin/stardoc/rules_ocaml.adoc docs/src/rules_ocaml/refman/ocaml-rules.adoc

rules_ocaml_sidebar:
	bazel build //stardoc:rules_ocaml_sidebar && sudo cp -v bazel-bin/stardoc/sidebar_rules_ocaml.adoc docs/_data/sidebars/sidebar_rules_ocaml.yml

providers:
	bazel build //stardoc:providers_ocaml && sudo cp -v bazel-bin/stardoc/providers_ocaml.adoc docs/rules_ocaml/refman
