[User Guide](index.md)

**WARNING** Support for C/C++ deps is still under development. What's
  there works but the interface will likely change since there are
  still some issues to be worked out, such as how best to support
  different link modes and options for each CC dependency.

# CC Dependencies

A "CC dependency" is often a C/C++ library, but this terminology is a
little misleading. A `C/C++ library` need not necessarily be produced
from C/C++ source code. Rather it refers to the standard file format
for object files, archives, etc., which is historically is closely
associated with C. Many other languages (including OCaml) are capable
of producing such files, so OBazl may use 'CC' terminology (e.g. `CC
library`, `cc_deps`) to refer to such files no matter what language
was used to produce them.

## CC Libraries

A library is a collection of code units. C/C++ libraries come in
several flavors:

* an unpackaged collection of object files (with `.o` extension)

* a _static_ 'library': a collection of code units (object files)
  packaged as an _archive_ file, whose extension (by convention) is
  `.a`.

* a _dynamic shared_ 'library': code units (object files) packaged as
  a _dynamic shared object_ (DSO) file. Yes, the terminology conflates
  two distinct concepts; OBazl generally treats 'dynamic' and 'shared'
  as synonyms. On Linux, these are `.so` files; on MacOS, they are
  `.dylib` files (but MacOS also supports `.so` files).

## Dynamic Loading ('Plugins')

[TODO: document dynamic loading of CC deps; compare OCaml *.cmxs
files. Distinction between linking and loading.]

## Linkmode

Rules producing CC libs commonly produce both a static archive ('.a'
file) and one or more shared libraries ('.so' or '.dylib' files). In
Obazl rules, _link mode_ determines which type of library is used for
linking. Possible values:

* 'static': statically link to `.a` file.
* 'dynamic': depending on the OS, link to '.dylib' file (MacOS) or '.so' file (Linux or MacOS).
* 'shared': synonym for 'dynamic'
* 'default': by default, equivalent to 'static' on Linux, 'dynamic' on MacOS.

**WARNING** The 'default' linkmode is configurable. The default value
  for linkmode 'default' is as noted above. To override the default
  for all rules, pass command-line option `--@ocaml//linkmode`; for
  example, to set default value for linkmode 'default' to 'dynamic'
  pass `--@ocaml//linkmode:dynamic`.

### Static Binaries

**WARNING** MacOS does not support statically linked binaries (ie.
  executables). See [Statically linked binaries on Mac OS
  X](https://developer.apple.com/library/archive/qa/qa1118/_index.html)

[TODO: flesh this out]