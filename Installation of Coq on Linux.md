You can install CoqIDE either as a package or by compiling it form sources.

Installation from packages
--------------------------

To install Coq and CoqIDE, open a shell and run the following command: 

<strong class="highlight">.. raw:: html

</strong>[Table not converted]

To check that the installation is successful, run the command "``coqc -v``".

Then, you should configure CoqIDE bindings. This step is optional but strongly recommended, as the default bindings very often conflict with the bindings of the window manager. To that end, all you need to do is to copy a new binding file, as described on the page:

* `Configure the key bindings`_

To check that CoqIDE is correctly installed and configured, run the command:

<strong class="highlight">.. raw:: html

</strong>[Table not converted]

Then, type ``Check True.`` and use the menu "Navigation", "Forward" to get Coq to check the definition.

**Remark:** the installation of **Proof General** should be described here.

Installation from sources
-------------------------

Requirements
~~~~~~~~~~~~

In a nutshell:

<strong class="highlight">.. raw:: html

</strong>[Table not converted]

Packages required for building Coq:

* **GNU Make => 3.81** (package "gnu-make")

* **OCaml >= 3.11.2** (package "ocaml")

* **Camlp5 => 5.10** (package "camlp5") --TODO: it might not be necessary with Coq >= v8.4

Packages required only for building CoqIDE:

* LablGtk_ (package "liblablgtk2-ocaml-dev")

* **GTK+** libraries (package "libgtk2.0-dev")

Packages required only for obtaining Coq sources from the svn repository:

* SVN (package "subversion") 

Packages required only for generating documentation: (you likely don't need it)

* Hevea (package "hevea")

Downloading the sources
~~~~~~~~~~~~~~~~~~~~~~~

By default, you should get the archive version. If you are an advanced users, you may consider using an svn version.

**Archive version (default):** 

1. Download_ the Coq sources for the version that you want

#. deflate the archive, e.g. running "``tar -xvzf coq-8.4pl0.tar.gz``"  

**Svn version:** to get it, run:

<strong class="highlight">.. raw:: html

</strong>[Table not converted]

Warning: the svn version might contain some bug-fixes so it can be slightly different from the archive version.

**Trunk version:** if you want to try a feature from the trunk version, then run:

<strong class="highlight">.. raw:: html

</strong>[Table not converted]

Warning: the trunk is *not* stable, it might not even compile.

Choice of the target folder
~~~~~~~~~~~~~~~~~~~~~~~~~~~

First, enter the folder that contains the sources. Then, choose among:

**Global installation (default):** if you want to install only one version of Coq installed and if you have root priviledges, then do:

<strong class="highlight">.. raw:: html

</strong>[Table not converted]

**Local installation:** if you only want to go for a local installation of Coq (i.e., leaving the binaries in the ./bin folder), then run:

<strong class="highlight">.. raw:: html

</strong>[Table not converted]

After running the configure command, you should be able to read:

[Table not converted]

Moreover, if you plan to install CoqIDE, you should be able to read:

[Table not converted]

If LablGtk2_ is not found, you may try to add the option ``-lablgtkdir /usr/lib/ocaml/lablgtk2/`` to specify the directory.

It is useless to continue if you don't succeed at this stage.

Remark: the packaged version of v8.4pl0 has a known problem is localizing LablGtk2_; a simple work around is to use the svn sources of v8.4.

Compilation of Coq and CoqIDE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To compile, run:

<strong class="highlight">.. raw:: html

</strong>[Table not converted]

If everything works fine, the standard library should compile and then coqide should compile, without errors.

Then, if you used "``-prefix /usr/local``", run 

<strong class="highlight">.. raw:: html

</strong>[Table not converted]

To test the success of the installation, run "``coqc -v``" and "``coqide &``". If you plan on using CoqIDE, then it is very important that you  `fix the key bindings for CoqIDE`_.

Otherwise, if you went for a local installation with the option "``-local``", simply  test the binaries using the commands "``bin/coqc -v``" and "``bin/coqide &``".

.. ############################################################################

.. _Configure the key bindings:
.. _fix the key bindings for CoqIDE: ../Configuration of CoqIDE

.. _LablGtk: ../LablGtk

.. _Download: http://coq.inria.fr/download

.. _LablGtk2: ../LablGtk2

.. _CoqIde: ../CoqIde

