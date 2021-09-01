# configs, constraints, platforms, etc.

Concepts:

* configuration state
*

Dependency on configuration state is expressed as a kind of constraint
satisfaction problem. The `*values` attributes in `config_setting`
rules and the `constraint_values` in platform rules, etc. express
constraints that are satisfied or not based on configuration state.

Configuration state is set via the following mechanisms:

* command line flags, e.g. `--compilation_mode=opt` (equivalently, `-c opt`)
* platform rules passed by command line
* command line `--define` options, e.g. `--define a=1`
* rc file settings, e.g. options written in `.bazelrc` or other rc file
* auto-detected host properties (e.g. cpu type)

Platform rules are effectively syntactic sugar. "Activating" a
platform rule, by passing it on the command line (e.g.
`--platforms=//:foo/bar`), satisfies its constraint_values, by
stipulation as it were.


## config_setting

https://docs.bazel.build/versions/main/be/general.html#config_setting

```
config_setting(name,
    constraint_values,
    values,              ## from command-line flags
    flag_values,         ## same as values but for Starlark-defined flags
    define_values,       ## same as values but exclusively for --define flags

    deprecation,
    distribs,
    features,
    licenses,
    tags,
    testonly,
    visibility
)
```

A config_setting is _satisfied_ if all of its `*_values` attributes
are satisfied (i.e. True). The "values" describe config state, and are
True just in case ...



