
default:
	bazel build //stardoc:rules_ocaml && sudo cp -v bazel-bin/stardoc/rules_ocaml.adoc docs/rules_ocaml/refman

providers:
	bazel build //stardoc:providers_ocaml && sudo cp -v bazel-bin/stardoc/providers_ocaml.adoc docs/rules_ocaml/refman
