# getting started

1.  Install and configure OPAM

    * Download and run the install.sh script

    * Initialize OPAM.

      * OPAM depends on a short list of resources that must be
        installed in the host environment. Run `$ opam init`, and it
        will tell you what it needs in order to run.

      * It will print a list of recommended and required deps. You
        will need to use your system package manager to install these.
        For example, on a fresh Ubuntu 20.4 LTS VM I got:

        * Recommended: make, m4, cc. The recommended way to install
          `make` and `cc` and other dev tools (on Linux) is to install
          package `build_essential`; package `m4` must be installed separately.

          * `$ sudo apt-get install build-essential`

        * Required (but missing): unzip, bwrap. Follow opam's
          instructions: install `bubblewrap` and `unzip`.

    * OPAM initialization will install a bare-bones default
      [switch](https://opam.ocaml.org/doc/Usage.html#opam-switch)
      based on the most recent version of the compiler. If you need an
      earlier version, run `$ opam switch create` as per the opam documentation.

    * Opam will print a message instructing you to run a command like
      `eval $(opam env)`. If you do not run this, things (esp. PATH)
      will not be configured properly and annoying problems will
      arise.

    * OBazl depends on `ocamlfind`, which you must install: `$ opam install ocamlfind`.

    * Install any other OPAM packages that your software depends on.

2.  Install Bazel or Bazelisk (preferred).

    * If you install Bazelisk by downloading a binary release, you'll
      get an executable file named something like
      `bazelisk-linux-amd64`. Recommendation: move the bazelisk file
      to `$HOME/bin`, and create a soft link to `$HOME/bazel`. (Put
      `$HOME/bin` on your path if not already there). You may need to
      logoff and logon again, or source your rc files for this to take
      effect.

3.  Install `git` and other development tools.