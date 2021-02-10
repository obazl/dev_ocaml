## NOTE: rules must be aliased.

load("@obazl_rules_ocaml//ocaml:providers.bzl",
     _OcamlArchiveProvider = "OcamlArchiveProvider",
     _OcamlDepsetProvider  = "OcamlDepsetProvider",
     _OcamlImportProvider  = "OcamlImportProvider",
     _OcamlLibraryProvider = "OcamlLibraryProvider",
     _OcamlModuleProvider    = "OcamlModuleProvider",
     _OcamlNsLibraryProvider  = "OcamlNsLibraryProvider",
     _OcamlSignatureProvider = "OcamlSignatureProvider",
     )

OcamlArchiveProvider   = _OcamlArchiveProvider
OcamlDepsetProvider    = _OcamlDepsetProvider
OcamlImportProvider    = _OcamlImportProvider
OcamlLibraryProvider   = _OcamlLibraryProvider
OcamlModuleProvider    = _OcamlModuleProvider
OcamlNsLibraryProvider  = _OcamlNsLibraryProvider
OcamlSignatureProvider = _OcamlSignatureProvider
