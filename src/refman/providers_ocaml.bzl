## NOTE: rules must be aliased.

load("@obazl_rules_ocaml//ocaml:providers.bzl",
     _AdjunctDepsProvider = "AdjunctDepsProvider",
     _CcDepsProvider = "CcDepsProvider",
     _OcamlArchiveProvider = "OcamlArchiveProvider",
     _OcamlExecutableProvider = "OcamlExecutableProvider",
     _OcamlImportProvider  = "OcamlImportProvider",
     _OcamlLibraryProvider = "OcamlLibraryProvider",
     _OcamlModuleProvider    = "OcamlModuleProvider",
     _OcamlNsArchiveProvider  = "OcamlNsArchiveProvider",
     _OcamlNsEnvProvider  = "OcamlNsEnvProvider",
     _OcamlNsLibraryProvider  = "OcamlNsLibraryProvider",
     _OcamlSignatureProvider = "OcamlSignatureProvider",
     _OpamDepsProvider  = "OpamDepsProvider",
     )

CcDepsProvider   = _CcDepsProvider
AdjunctDepsProvider   = _AdjunctDepsProvider
OcamlArchiveProvider   = _OcamlArchiveProvider
OcamlExecutableProvider = _OcamlExecutableProvider
OcamlImportProvider    = _OcamlImportProvider
OcamlLibraryProvider   = _OcamlLibraryProvider
OcamlModuleProvider    = _OcamlModuleProvider
OcamlNsArchiveProvider  = _OcamlNsArchiveProvider
OcamlNsEnvProvider      = _OcamlNsEnvProvider
OcamlNsLibraryProvider  = _OcamlNsLibraryProvider
OcamlSignatureProvider = _OcamlSignatureProvider
OpamDepsProvider       = _OpamDepsProvider
