OBazl User Guide
================

[Developing OCaml software with OBazl](development.md)

------------------------------------------------------------------------

-   [Bootstrapping](bootstrap.md)
-   [Caching](caching.md)
-   [Conditional Compilation/Building](conditional.md)
-   [Configuration](configuration.md)
    -   [Bazel Configurations](configuration.md#bazel)
    -   [OPAM Rules Configuration](configuration.md#opamconfig)
    -   [OCaml Rules Configuration](configuration.md#ocamlconfig)
    -   [Configuration Rules](configrules.md)
    -   [Config Profiles](configprofiles.md)
-   [Conventions](conventions.md)
-   [Dependency Management](depmgmt.md)
    -   [OCaml Dependencies](dependencies_ocaml.md)
    -   [OPAM Dependencies](dependencies_opam.md)
    -   [CC Dependencies](dependencies_cc.md)
-   [Deployment](deployment.md)
    -   [Stamping binaries](stamping.md)
-   [File Generation](filegen.md)
-   [Interop](interop.md)
-   [Maintenance Tasks](maintenance.md)
-   [Namespacing](namespacing.md) (i.e. "type-level aliases")
-   [Offline development](offline.md)
-   [PPX Support](ppx.md)
-   [Querying Dependency Graphs](querying.md)
-   [Repositories](workspaces.md)
-   [Refactoring](refactoring.md)
-   Rules
    -   [Bootstrapping](bootstrap.md#rules)
    -   [Build Rules](build_rules.md)
    -   [Configuration Rules](configrules.md)
-   [Stamping](stamping.md)
-   Target labels
    -   [Specifying targets to
        build](https://docs.bazel.build/versions/master/guide.html#specifying-targets-to-build)
    -   [Labels](https://docs.bazel.build/versions/master/build-ref.html#labels)
    -   `$ bazel help target-syntax`
-   [Testing](testing.md)
-   [Toolchains](toolchains.md)
    -   [ocamlfind](toochains.md#ocamlfind)
    -   [ocamlc/ocamlopt](toochains.md#ocamlc)
-   [Tools](tools.md)
-   [Transparency](transparency.md): Inspecting Build Commands, Actions,
    etc.
-   [Troubleshooting](troubleshooting.md)
-   [user.bazelrc](user_bazelrc.md)
-   [Workspaces](workspaces.md)

### Additional Topics

-   [Phases of a
    build](https://docs.bazel.build/versions/master/guide.html#phases-of-a-build),
    [Evaluation
    Model](https://docs.bazel.build/versions/master/skylark/concepts.html#evaluation-model)
-   [Offline
    builds](https://docs.bazel.build/versions/master/external.html#offline-builds)
-   [Containerization](https://github.com/bazelbuild/rules_docker)
-   Continuous Integration
    -   [Using Bazel in a continuous integration
        system](https://blog.bazel.build/2016/01/27/continuous-integration.html) -
        Bazel blog article (2016)
    -   [Continuous Integration on a Huge Scale Using
        Bazel](https://www.wix.engineering/post/continuous-integration-on-a-mammoth-scale-using-bazel) -
        WiX Engineering
    -   [Using Bazel on
        Buildkite](https://buildkite.com/docs/tutorials/bazel)
-   [Persistent
    workers](https://docs.bazel.build/versions/master/persistent-workers.html)
-   [Remote
    caching](https://docs.bazel.build/versions/master/remote-caching.html)
-   [Remote
    execution](https://docs.bazel.build/versions/master/remote-execution.html)
-   [Platforms](https://docs.bazel.build/versions/master/platforms.html) -
    cross-platform development
