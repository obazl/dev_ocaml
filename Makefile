default: rules_ocaml sidebars tools_ocaml providers

rules_ocaml:
	bazel build //stardoc:rules_ocaml \
	&& sudo cp -v .bazel/bin/stardoc/rules_ocaml.adoc docs/rules-ocaml/reference/ocaml-rules.adoc

sidebars:
	bazel build //stardoc:rules_ocaml_sidebar \
	&& sudo cp -v .bazel/bin/stardoc/sidebar_rules_ocaml.yml docs/_data/sidebars/sidebar_rules_ocaml_refman.yml

tools_ocaml:
	bazel build //stardoc:bindiff
	bazel build //stardoc:cppo
	bazel build //stardoc:menhir
	sudo cp -v .bazel/bin/stardoc/bindiff_test.adoc docs/tools-ocaml/reference/
	sudo cp -v .bazel/bin/stardoc/cppo.adoc docs/tools-ocaml/reference/
	sudo cp -v .bazel/bin/stardoc/menhir.adoc docs/tools-ocaml/reference/

providers:
	bazel build //stardoc:providers_ocaml \
	&& sudo cp -v .bazel/bin/stardoc/ocaml-providers.adoc docs/rules-ocaml/reference

functions:
	bazel build //stardoc:functions \
	&& sudo cp -v .bazel/bin/stardoc/functions.adoc docs/rules-ocaml/reference
