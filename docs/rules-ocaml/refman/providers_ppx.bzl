## NOTE: rules must be aliased.

load("@obazl_rules_ocaml//ocaml:providers.bzl",
     _PpxDepsetProvider = "PpxDepsetProvider",
     _PpxArchiveProvider = "PpxArchiveProvider",
     _PpxExecutableProvider  = "PpxExecutableProvider",
     _PpxModuleProvider  = "PpxModuleProvider"
     )

PpxDepsetProvider = _PpxDepsetProvider
PpxArchiveProvider = _PpxArchiveProvider
PpxExecutableProvider = _PpxExecutableProvider
PpxModuleProvider = _PpxModuleProvider
