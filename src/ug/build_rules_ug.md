[User Guide](index.md)

# Build Rules

## <a name="modules">Modules</a>

An OCaml module is a composite formed by pairing a
[signature](#signatures)
and a
[structure](#structures).

## <a name="signatures">Signatures</a>

A signature expressed as a file is traditionally called an
"interface". The filename conventionally has a ".mli" extension, but
this is not required, since a `-intf` parameter may be used to
designate a sigfile.

OBazl calls such files _signature files_, or _sigfiles_ for short. The
`ocaml_signature` rule is used to compile them.

## <a name="structures">Structures</a>

Every structfile determines a module. If no signature is provided, the
OCaml compiler will infer the signature from the structure. For this
reason, OBazl uses the `ocaml_module` rule to compile structfiles;
there is no `ocaml_structure` rule.

## The Build Rules

* [ocaml_archive](ocaml_archive.md)
* [ocaml_executable](ocaml_executable.md)
* [ocaml_import](ocaml_import.md)
* [ocaml_interface](ocaml_interface.md)
* [ocaml_libary](ocaml_library.md)
* [ocaml_module](ocaml_module.md)
* [ocaml_ns](ocaml_ns.md)
