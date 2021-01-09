## NOTE: rules must be aliased.

load("@obazl_rules_ocaml//ocaml/_rules:ocaml_archive.bzl"    , _ocaml_archive = "ocaml_archive")
load("@obazl_rules_ocaml//ocaml/_rules:ocaml_executable.bzl" , _ocaml_executable = "ocaml_executable")
load("@obazl_rules_ocaml//ocaml/_rules:ocaml_import.bzl"     , _ocaml_import = "ocaml_import")
load("@obazl_rules_ocaml//ocaml/_rules:ocaml_interface.bzl"  , _ocaml_interface = "ocaml_interface")
load("@obazl_rules_ocaml//ocaml/_rules:ocaml_library.bzl"    , _ocaml_library = "ocaml_library")
load("@obazl_rules_ocaml//ocaml/_rules:ocaml_module.bzl"     , _ocaml_module = "ocaml_module")
load("@obazl_rules_ocaml//ocaml/_rules:ocaml_ns.bzl"         , _ocaml_ns = "ocaml_ns")

ocaml_archive = _ocaml_archive
ocaml_executable = _ocaml_executable
ocaml_import = _ocaml_import
ocaml_interface = _ocaml_interface
ocaml_library = _ocaml_library
ocaml_module  = _ocaml_module
ocaml_ns  = _ocaml_ns

