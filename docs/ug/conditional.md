conditional compilation
=======================

Use the
[select](https://docs.bazel.build/versions/master/be/functions.html#select)
function to choose dependencies to build.

You can use `select` to control any [configurable
attribute](https://docs.bazel.build/versions/master/configurable-attributes.html),
such as `opts`.
