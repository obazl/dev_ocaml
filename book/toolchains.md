# toolchains

## bazel toolchains

### declaration, definition, and selection of toolchains

[defining toolchains](https://docs.bazel.build/versions/main/toolchains.html#defining-toolchains)

```
To define some toolchains for a given toolchain type, you need three things:

1. A language-specific rule representing the kind of tool or tool suite. By convention this rule’s name is suffixed with “_toolchain”.

2. Several targets of this rule type, representing versions of the tool or tool suite for different platforms.

3. For each such target, an associated target of the generic toolchain rule, to provide metadata used by the toolchain framework. This toolchain target also refers to the toolchain_type associated with this toolchain. This means that a given _toolchain rule could be associated with any toolchain_type, and that only in a toolchain instance that uses this _toolchain rule that the rule is associated with a toolchain_type.

```

The terminology here is a little awkward; we have to kinds of
toolchain rule, the "language-specific rule" and the "generic
toolchain rule".  Also unclear are the distinctions between declaration, definition, and selection of toolchains.

To avoid confusion we adopt the following terminology:

#### family of toolchains

A "language-specific rule" must produce a `ToolchainInfo` provider, so
we could call it a "toolchain-info" rule. However, as described below,
such rules implicitly define a family of toolchains, so we will call
them "toolchain-family" rules.

Such rules do not, strictly speaking, _define_ a toolchain; it's more
of a _declaration_ that generates a definition when provided with
arguments. That is, it declares (defines?) an abstract structure of
tools (and other resources, such as files and directories needed by
the tools), and it is up to the user to _define_ those tools by
applying the rule to a set of arguments. In other words such a rule
defines a _**family**_ of toolchains.

In the following examples we are defining toolchains for a (fictional) programming language named `barlang`.

Consider the example at [Defining toolchains](https://docs.bazel.build/versions/main/toolchains.html#defining-toolchains) (warning: we've changed `bar` to `barlang`):

```
For our running example, here’s a definition for a barlang_toolchain rule. Our example has only a compiler, but other tools such as a linker could also be grouped underneath it.

def _barlang_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        barlangInfo = BarlangInfo(
            compiler_path = ctx.attr.compiler_path,
            system_lib = ctx.attr.system_lib,
            arch_flags = ctx.attr.arch_flags,
        ),
    )
    return [toolchain_info]

barlang_toolchain = rule(               ## our convention: def_barlang_toolchain = rule(...)
    implementation = _barlang_toolchain_impl,
    attrs = {
        "compiler_path": attr.string(),
        "system_lib": attr.string(),
        "arch_flags": attr.string_list(),
    },
)
```

Here `barlang_toolchain` does nothing more than wrap some parameters
in a `ToolchainInfo` structure. It does not _define_ a compiler, for
example; it only _declares_ that each `barlang` toolchain must define
a `compiler_path`, etc. In addition, it does _not_ define a toolchain;
rather, it implicitly defines a _**family**_ of toolchains. The family
is parameterized by the rule attributes; providing a particular set of
attributes selects a member of the family. Thus it is the _use_ of
such a rule that defines (selects) a (concrete) toolchain.

**IMPORTANT** A "language-specific" toolchain rule implicitly defines
a family of toolchains (it defines the family, not the toolchains)
but this family is _not_ related to any (toolchain) type defined by a
`toolchain_type` rule.

The standard convention is to name such rules with a "_toolchain"
suffix; this is plainly confusing, since targets defined using such
rules are also appropriately named with the same suffix, not to
mention "instances" of the generic toolchain rule.

To use such a rule is to define a toolchain; therefore, to bring this
logic to the surface, we will follow the convention of naming such
rules with prefix `def_` and suffix `_toolchain`. So when used we will
have `def_barlang_toolchain(...)` instead of `barlang_toolchain(...)`.

To name such toolchains defined using a toolchain-family rule we use
prefix `barlang_toolchain` (or an unambiguous abbreviation where
possible, e.g. `barlang_tc`), e.g.

```
def_barlang_toolchain(
    name = "barlang_tc_linux",
    arch_flags = [
        "--arch=Linux",
        "--debug_everything",
    ],
    compiler_path = "/path/to/barlang/on/linux",
    system_lib = "/usr/lib/libbarlang.so",
)
```

We reserve "toolchain" for the toolchains defined as just described - by parameterizing a toolchain-family rule to select a concrete toolchain.
Note that this is in contrast to standard Bazel usage, which uses the
term "toolchain" somewhat loosely.

**IMPORTANT** Do not confuse toolchain definitions and tool
definitions. In our example, we are defining toolchains in package
`//barlang_tools`, and the tools are named in some manner using `barlang`.
But a toolchain can use whatever tools you care to define for it. In
our example: the resources used to parameterize `def_barlang_toolchain`
need not have any relation to `barlang_tools`. Furthermore, the toolchain
mechanism described here (declaration, definition, selection) does not
_build_ the tools, it only configures/selects tools, which may be
built by other rules, or by processes outside of Bazel.


The generic toolchain rule (`toolchain`, defined by Bazel itself) is
simply misnamed. It neither defines nor declares a toolchain; rather
binds a toolchain-info target (defined by applying `def_*_toolchain`
to args) to a toolchain_type target, and expresses a set of
compatibility constraints governing selection of the (generic
toolchain) rule during toolchain resolution at build time. So we'll
call it a "toolchain-selector", and name it using suffix
`_toolchain_selector` (or `_tc_selector`). Continuing the example:

```
toolchain(  ## misnamed; should be something like `toolchain_selector` or `toolchain_spec` or the like
    name = "barlang_tc_linux_selector",  ## not "barlangc_linux_toolchain"
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":barlang_tc_linux",   ## instead of :barlangc_linux
    toolchain_type = ":toolchain_type", ## bad; should name the type, e.g. barlang_tools_tc
)
```

Even this is rather weak, though. A `toolchain` rule always selects a
toolchain of a particular type (value of the `toolchain-type`
attribute); why not make that explicit in the target name? To support
this, the first step is to give toolchain types meaningful names,
rather than merely `:toolchain_type` (which effectively conveys no
information). The convention recommended by Bazel is to always use the
name "toolchain_type" for `toolchain_type` targets, and to rely on the
package path to distinguish toolchain types, which would give us
toolchain type labels like `//foo:toolchain_type`,
`//barlang:toolchain_type`. We think this is a (very) bad idea and instead
recommend choosing a target name that conveys meaningful information; for
example, `//foo:foo_tc`, `//barlang:barlang_tc`. That makes the
`toolchain_type` attribute of the `toolchain` rule more legible:
`toolchain_type = ":barlang_tc"` instead of `toolchain_type =
":toolchain_type"`, which conveys little information.

Note that we need not suffix `_type` to the names of such
targets, any more that we need to suffix it to type names like "int".

(A counterargument might be that since `:toolchain_type` implies
`barlang_tools:toolchain_type`, there is no missing information. But this
is cumbersome; among other things, it means that such a code fragment
cannot be used out of context (e.g. in documentation) without also
providing the package name. Furthermore, what if more than one
`toolchain_type` is defined in package `//barlang_tools`? Of course,
another option is to always use the fully-qualified label of
`toolchain_type` rules.)

Following our conventions:

[in barlang_tools/BUILD.bazel]
```
toolchain_type(name = "barlang_tc")  ## not "toolchain_type"

# declare (a family of toolchains)
_def_barlang_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(...)
    return [toolchain_info] # effectively defines a family of toolchains

def_barlang_toolchain = rule(
    implementation = _def_barlang_toolchain_impl,
    attrs = {...}

# parameterize def_* rule to define (select) some (concrete) toolchains from the family
def_barlang_toolchain(
    name = "barlang_tc_linux",
    arch_flags = ["--arch=Linux", "--debug_everything"],
    compiler_path = "/path/to/barlang/on/linux",
    system_lib = "/usr/lib/libbarlang.so",
)

def_barlang_toolchain(  ## using a different barlang compiler on linux
    name = "barlang_tc_linux_x",
    arch_flags = ["--arch=Linux", "--debug_everything"],
    compiler_path = "/path/to/barlang/x/linux",
    system_lib = "/usr/lib/libbarlang.so",
)

def_barlang_toolchain(
    name = "barlang_tc_windows",
    arch_flags = ["--arch=Windows"],
    compiler_path = "C:\\path\\on\\windows\\barlang.exe",
    system_lib = "C:\\path\\on\\windows\\barlanglib.dll",
)

toolchain(
    name = "barlang_tc_linux_selector",
    toolchain_type = ":barlang_tc", toolchain = ":barlang_tc_linux",
    ... compatibility constraints ...
)
toolchain(
    name = "barlang_tc_linux_x_selector",
    toolchain_type = ":barlang_tc", toolchain = ":barlang_tc_linux_x",
    ... compatibility constraints ...
)
toolchain(
    name = "barlang_tc_windows_selector",
    toolchain_type = ":barlang_tc", toolchain = ":barlang_tc_windows",
    ... compatibility constraints ...
)

register_toolchains(
    "//bar_tools:barlang_tc_linux_selector",
    "//bar_tools:barlang_tc_linux_x_selector",
    "//bar_tools:barlang_tc_windows_selector",
)

## a build rule that uses the toolchain, possibly defined in a different BUILD file
def _barlang_binary_impl(ctx):
    ...
    info = ctx.toolchains["//barlang_tools:barlang_tc"].barlangcinfo
    ...

barlang_binary = rule(
    implementation = _barlang_binary_impl,
    attrs = {...},
    toolchains = ["//barlang_tools:barlang_tc"]
)

```

IOW, the toolchain is declared by the toolchain-info rule, defined by
application of the toolchain-info rule, and selected for use by the
toolchain-selector rule.

### tool definition

Toolchains use tools; they do not define or build them.



## ocaml toolchains

https://github.com/ocaml/ocaml

The main branch is `trunk`.

### code structure

#### runtime

Mostly C code, but a few `.asm` and `.S` files.

* `runtime` - contains C implementation code and headers.
* `runtime/caml` - public C API headers; in OPAM, this ends up in e.g. `~/.opam/4.11.1/lib/ocaml/caml`

**NOTE** `runtime/Makefile` is _not_ generated by `.configure`

#### Other C sources

Other dirs containing C sources:

```
$ fd -e c -x echo {//} | sort | uniq
ocamltest
otherlibs/bigarray
otherlibs/str
otherlibs/systhreads
otherlibs/unix
otherlibs/win32unix
runtime
stdlib
testsuite/tests/asmcomp
testsuite/tests/asmgen
testsuite/tests/basic
testsuite/tests/basic-manyargs
testsuite/tests/c-api
testsuite/tests/callback
testsuite/tests/compatibility
testsuite/tests/embedded
testsuite/tests/ephe-c-api
testsuite/tests/gc-roots
testsuite/tests/int64-unboxing
testsuite/tests/lib-bigarray-2
testsuite/tests/lib-dynlink-bytecode
testsuite/tests/lib-dynlink-csharp
testsuite/tests/lib-dynlink-native
testsuite/tests/lib-dynlink-pr9209
testsuite/tests/lib-marshal
testsuite/tests/lib-threads
testsuite/tests/lib-unix/common
testsuite/tests/lib-unix/win-env
testsuite/tests/lib-unix/win-stat
testsuite/tests/locale
testsuite/tests/manual-intf-c
testsuite/tests/output-complete-obj
testsuite/tests/regression/pr3612
testsuite/tests/runtime-C-exceptions
testsuite/tests/runtime-naked-pointers
testsuite/tests/statmemprof
testsuite/tests/tool-command-line
testsuite/tests/unboxed-primitive-args
testsuite/tests/unwind
tools
utils
yacc
```

#### stdlib

Sources in `stdlib`. OPAM: ends up at `~/.opam/4.11.1/lib/ocaml`

#### otherlibs

Small collection of libs involving C FFI: `bigarray`, `dynlink`,
`str`, `systhreads`, `unix`, `win32unix`.

### building

Prereqs:

* C toolchain
  * compiler
  * binutils: `ar`, `ran`, `strip`
* GNU Make
* Posix-compatible
  * sed
  * awk
  * diff (to run tests)
* Cygwin: `gcc-core`, `flexdll`

#### CC tools

Depends twice on C compiler: once to build the OCaml compilers, which
in turn may invoke the C compiler/assembler to compile OCaml source
code.

#### configure

Lots of feature-testing.

Source templates:
* Makefile.config.in
* Makefile.build_config.in
* runtime/caml/m.h.in
* runtime/caml/s.h.in

Uses standard env vars to discover compiler etc: `CC`, `CFLAGS`, `CPPFLAGS`, `LIBS`.  Also uses OCaml-specific vars `OC_CFLAGS`, `OC_LDFLAGS1`.

[aclocal.m4]
```
# The following macro figures out which C compiler is used.
# It does so by checking for compiler-specific predefined macros.
# A list of such macros can be found at
# https://sourceforge.net/p/predef/wiki/Compilers/
AC_DEFUN([OCAML_CC_VENDOR], [
  AC_REQUIRE([AC_PROG_CC])
  AC_REQUIRE([AC_PROG_CPP])
  AC_MSG_CHECKING([C compiler vendor])
  AC_PREPROC_IFELSE(
    [AC_LANG_SOURCE([
#if defined(_MSC_VER)
msvc _MSC_VER
#elif defined(__INTEL_COMPILER)
icc __INTEL_COMPILER
#elif defined(__clang_major__) && defined(__clang_minor__)
clang __clang_major__ __clang_minor__
#elif defined(__GNUC__) && defined(__GNUC_MINOR__)
gcc __GNUC__ __GNUC_MINOR__
#elif defined(__xlc__) && defined(__xlC__)
xlc __xlC__ __xlC_ver__
#elif defined(__SUNPRO_C)
sunc __SUNPRO_C __SUNPRO_C
#else
unknown
#endif]
    )],
    [AC_CACHE_VAL([ocaml_cv_cc_vendor],
      [ocaml_cv_cc_vendor=`grep ['^[a-z]'] conftest.i | tr -s ' ' '-' \
                                                      | tr -d '\r'`])],
    [AC_MSG_FAILURE([unexpected preprocessor failure])])
  AC_MSG_RESULT([$ocaml_cv_cc_vendor])
])
```

[configure.ac]
```
# Command to build executalbes
# In general this command is supposed to use the CFLAGs- and LDFLAGS-
# related variables (OC_CFLAGS and OC_LDFLAGS for ocaml-specific
# flags, CFLAGS and LDFLAGS for generic flags chosen by the user), but
# at the moment they are not taken into account on Windows, because
# flexlink, which is used to build executables on this platform, can
# not handle them.
mkexe="\$(CC) \$(OC_CFLAGS) \$(CFLAGS) \$(OC_LDFLAGS) \$(LDFLAGS)"
```

#### cross-compilation
