[User Guide](index.md)

# misc

* ocamlfind v. ocamlc/ocamlopt - different parameter set
* [target patterns](https://docs.bazel.build/versions/master/guide.html#target-patterns)

## the build processing phases


1) The Loading phase is when Bazel is reading in BUILD and .bzl files, and creating the target graph that is used for later work
2) The Analysis phase is when Bazel is applying the configuration to the target graph to produce the configured target and action graphs
3) The Execution phase is when Bazel begins actually deciding which actions to execute, based on the current state and the desired build artifacts

The distinction between Loading and Analysis isn't "we don't have a configuration during Loading", it's "Loading reads files and produces a target graph, which is a direct translation of what is in the build files", and "Analysis actually begins to consider what those targets mean". It's similar to the syntax and semantics distinction made in compiler theory.

(src: https://mail.google.com/mail/u/1/#inbox/FMfcgxwKkRPDBLhNWkMPJxSnxXVcQKlf)