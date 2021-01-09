## NOTE: rules must be aliased.

load("@obazl_rules_ocaml//ocaml/_providers:ocaml.bzl",
     _OcamlArchivePayload  = "OcamlArchivePayload",
     _OcamlArchiveProvider = "OcamlArchiveProvider",
     _OcamlDepsetProvider  = "OcamlDepsetProvider",
     _OcamlLibraryProvider = "OcamlLibraryProvider",
     _OcamlImportProvider  = "OcamlImportProvider",
     _OcamlInterfaceProvider = "OcamlInterfaceProvider",
     _OcamlInterfacePayload  = "OcamlInterfacePayload",
     _OcamlModuleProvider    = "OcamlModuleProvider",
     _OcamlModulePayload     = "OcamlModulePayload",
     _OcamlNsModuleProvider  = "OcamlNsModuleProvider",
     _OcamlNsModulePayload   = "OcamlNsModulePayload"
     )

OcamlDepsetProvider    = _OcamlDepsetProvider
OcamlArchivePayload    = _OcamlArchivePayload
OcamlArchiveProvider   = _OcamlArchiveProvider
OcamlImportProvider    = _OcamlImportProvider
OcamlInterfaceProvider = _OcamlInterfaceProvider
OcamlInterfacePayload  = _OcamlInterfacePayload
OcamlLibraryProvider   = _OcamlLibraryProvider
OcamlModuleProvider    = _OcamlModuleProvider
OcamlModulePayload     = _OcamlModulePayload
OcamlNsModuleProvider  = _OcamlNsModuleProvider
OcamlNsModulePayload   = _OcamlNsModulePayload

load("@obazl_rules_opam//opam/_providers:opam.bzl", _OpamPkgInfo  = "OpamPkgInfo")
OpamPkgInfo = _OpamPkgInfo
