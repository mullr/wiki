You can install CoqIDE either as a package or by compiling it form sources.

Installation from packages
==========================

You may use your distribution package manager to install Coq and CoqIDE,
but this is likely to give you an older, outdated version of Coq.

For instance, on Debian / Ubuntu, the following should work:

```
sudo apt-get install coq coqide
```

To get the latest version of Coq, it is recommended instead to install Coq
using OPAM as documented [here](https://coq.inria.fr/opam/www/using.html)
or using [Nix](https://nixos.org/nix/).

To check that the installation is successful, run the command `coqc -v`.

To check that CoqIDE is correctly installed, run the command:

```
coqide &
```
You may want to change the default [key bindings for CoqIDE](Configuration%20of%20CoqIDE).

To install Proof-General, refer to the [official Proof-General website](https://proofgeneral.github.io/#quick-installation-instructions).

Installation from sources
=========================

Requirements: see INSTALL.md

**Archive version (default):**

1.  [Download](http://coq.inria.fr/download) the Coq sources for the version that you want
2.  deflate the archive, e.g. running `tar -xvzf coq-8.4pl0.tar.gz`

**Git version:** to get it, run:

```
git clone https://github.com/coq/coq.git
```

By default you will get the `master` branch, which is *not*
stable. You can switch to a stable branch (e.g. `v8.7`) via `cd coq && git checkout v8.7`.

Choice of the target folder
---------------------------

First, enter the folder that contains the sources. Then, choose among:

**Global installation (default):** if you want to install only one version of Coq installed and if you have root priviledges, then do:

```
./configure -prefix /usr/local
```

**Local installation:** if you only want to go for a local installation of Coq (i.e., leaving the binaries in the ./bin folder), then run:

```
./configure -local
```

After running the configure command, you should be able to read:

```
You have GNU Make 3.81. Good!
You have Objective-Caml 4.02.3. Good!
You have native-code compilation. Good!
```

Moreover, if you plan to install CoqIDE, you should be able to read:

```
LablGtk2 found, native threads: native CoqIde will be available.
````

It is useless to continue if you don't succeed at this stage.

Compilation of Coq and CoqIDE
-----------------------------

To compile, run:

```
make
```

If everything works fine, the standard library should compile and then coqide should compile, without errors.

Then, if you used `-prefix /usr/local`, run

```
sudo make install
```

To test the success of the installation, run `coqc -v` and `coqide &`.

Otherwise, if you went for a local installation with the option `-local`, simply test the binaries using the commands `bin/coqc -v` and `bin/coqide &`.
