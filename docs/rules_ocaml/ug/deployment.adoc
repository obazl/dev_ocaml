# deployment

Bazel is a build tool; it does not directly address packaging for
deployment. It's up to rules authors to support that kind of thing.

Providing a convenient means of packaging outputs for deployment is an
open issue. In the meantime, to deploy anything built using OBazl
rules, you will need to craft your own method of manipulating the
outputs emitted by the build rules.

If you have specify suggestions for addressing this, please [file an
issue](https://github.com/obazl/rules_ocaml/issues).

See also [Stamping binaries](stamping.md).