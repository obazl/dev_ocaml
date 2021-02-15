## NOTE: rules must be aliased.

# load("@obazl_rules_ocaml//ocaml/_rules:ppx_archive.bzl"       , _ppx_archive      = "ppx_archive")
load("@obazl_rules_ocaml//ocaml/_rules:ppx_executable.bzl"    , _ppx_executable   = "ppx_executable")
# load("@obazl_rules_ocaml//ocaml/_rules:ppx_library.bzl"       , _ppx_library      = "ppx_library")
# load("@obazl_rules_ocaml//ocaml/_rules:ppx_module.bzl"        , _ppx_module       = "ppx_module")
# load("@obazl_rules_ocaml//ocaml/_rules:ppx_expect_test.bzl"   , _ppx_expect_test  = "ppx_expect_test")
# load("@obazl_rules_ocaml//ocaml/_rules:ppx_ns_library.bzl"  , _ppx_ns_library   = "ppx_ns_library")
# load("@obazl_rules_ocaml//ocaml/_rules:ppx_test.bzl"          , _ppx_test         = "ppx_test")

# ppx_archive    = _ppx_archive
ppx_executable = _ppx_executable
# ppx_library    = _ppx_library
# ppx_module     = _ppx_module
# ppx_ns_library  = _ppx_ns_library
# ppx_expect_test = _ppx_expect_test

