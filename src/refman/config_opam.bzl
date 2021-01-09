## NOTE: rules must be aliased.

load("@obazl_rules_opam//opam:bootstrap.bzl", _opam_configure = "configure")
opam_configure = _opam_configure

load("@obazl_rules_opam//opam:providers.bzl", _OpamConfig = "OpamConfig", _OpamSwitch = "OpamSwitch")
OpamConfig = _OpamConfig
OpamSwitch = _OpamSwitch
