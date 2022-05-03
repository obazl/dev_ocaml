## NOTE: rules must be aliased.

load("@obazl_rules_opam//opam:bootstrap.bzl", _opam_configure = "configure")
opam_configure = _opam_configure

load("@obazl_rules_opam//opam/_providers:opam.bzl",
     _OpamPkgInfo  = "OpamPkgInfo",
     _OpamConfig = "OpamConfig",
     _OpamSwitch = "OpamSwitch"
     )
OpamPkgInfo = _OpamPkgInfo
OpamConfig = _OpamConfig
OpamSwitch = _OpamSwitch

