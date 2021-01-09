## NOTE: rules must be aliased.

load("@obazl_rules_ocaml//ppx:_providers.bzl",
     _PpxDepsetProvider = "PpxDepsetProvider",
     _PpxArchiveProvider = "PpxArchiveProvider",
     _PpxExecutableProvider  = "PpxExecutableProvider"
     )

PpxDepsetProvider = _PpxDepsetProvider
PpxArchiveProvider = _PpxArchiveProvider
PpxExecutableProvider = _PpxExecutableProvider
