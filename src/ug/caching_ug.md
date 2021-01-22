# caching

Bazel caches aggressively. In fact it caches just about everything.
Normally the caching just works, so you can ignore it. But if you want
to you can run `$ bazel clean`. This will "remove bazel-created
output, including all object files, and bazel metadata." To remove the
entire working tree, add the `--expunge` flag. You should almost never
need to do this.

## External repositories

Bazel caches all files downloaded (in external repositories) in the
_repository cache_. You can print its location with `$ bazel info
repository_cache`. For more information, see the section **The
Repository Cache** under [Fetching external dependencies](https://docs.bazel.build/versions/0.28.0/guide.html#fetch).

### Remote Caching

[Remote caching](https://docs.bazel.build/versions/master/remote-caching.html) - "A remote cache is used by a team of developers and/or a continuous integration (CI) system to share build outputs. If your build is reproducible, the outputs from one machine can be safely reused on another machine, which can make builds significantly faster."

[Setting up a Shared Build Cache using Bazel](https://www.tweag.io/blog/2020-04-09-bazel-remote-cache/) Blog post from [Tweag](https://www.tweag.io/)