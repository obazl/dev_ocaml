## NOTE: rules must be aliased.

load("@obazl_rules_ocaml//ppx:_providers.bzl",
     _PpxDepsetProvider = "PpxDepsetProvider",
     _PpxArchiveProvider = "PpxArchiveProvider",
     _PpxExecutableProvider  = "PpxExecutableProvider",
     _PpxModuleProvider  = "PpxModuleProvider"
     )

PpxDepsetProvider = _PpxDepsetProvider
PpxArchiveProvider = _PpxArchiveProvider
PpxExecutableProvider = _PpxExecutableProvider
PpxModuleProvider = _PpxModuleProvider
