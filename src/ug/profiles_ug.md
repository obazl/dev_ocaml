# Build Profiles and Contexts

Terminology:

* LSP - Language Support Package. This is the external repo that must
  be imported to support a given language.
* Context - the environment in which a program (build or meta-build) is evaluated.
* Profile - a set of options

## Build Profiles

A Build Profile is a set of Build Options. There are two kinds of
build options: meta-options that control Bazel itself, and
user-defined build options that control the (Starlark) build program
that executes within the Bazel environment.

For example:

[.bazelrc]
```
## meta-build options
build:dbg --subcommands=pretty_print
build:dbg --verbose_failures
build:dbg --sandbox_debug
## user-defined build options
build:dbg --//foo/bar
```

This defines a `dbg` build profile that can be activated by passing
`--config=dbg`.

## Build Contexts

* Root context - determined by WS file.
  * Project root context
  * LSP root context - determined by the WS file in the imported LSP repo.
* Initial context - root context, elaborated

