#title Installation of Coq on Linux

== Installation from packages ==

This is the simplest way to get the currently-packaged version of Coq and of an IDE, either CoqIDE or Proof General.

'''Coq'''. To install Coq, open a shell and run the following command: 

||<rowstyle="background-color: #FFFFE0;"> `sudo apt-get install coq` ||

To check that the installation is successful, run the command "`coqc -v`".

'''CoqIDE'''. If you want to use CoqIDE, which is recommended for beginners, run:

||<rowstyle="background-color: #FFFFE0;"> `sudo apt-get install coqide` ||

To check that the installation is successful, run the command "`coqide &`".
Then, it is very important that you  [[Configuration of CoqIDE|fix the key bindings for CoqIDE]].

'''Proof General'''. If you want to use Proof General instead of CoqIDE, run: 

||<rowstyle="background-color: #FFFFE0;"> TODO ||


== Installation from sources ==

=== Requirements ===

Packages required for building Coq:
 * '''GNU Make => 3.81''' (package "gnu-make")
 * '''OCaml >= 3.12.0''' (package "ocaml")
 * '''Camlp5 => 5.10''' (package "camlp5")

Only required for building CoqIDE:
 * LablGtk (package "liblablgtk2-ocaml-dev")
 * GTK+ libraries (package "libgtk2.0-dev")

Only required for generating documentation:
 * Hevea (package "hevea")

Only required for compiling versions of Coq from the svn repository:
 * SVN (package "subversion") 


=== Downloading the sources ===

By default, you should get the archive version. If you are an advanced users, you may consider using an svn version.

'''Archive version (default):''' 
 1. [[http://coq.inria.fr/download|Download]] the Coq sources for the version that you want
 1. deflate the archive, e.g. running "`tar -xvzf coq-8.4pl0.tar.gz`"  

'''Svn version:''' to get it, run:

||<rowstyle="background-color: #FFFFE0;"> `svn checkout svn://scm.gforge.inria.fr/svn/coq/branches/v8.4 coq-v8.4` ||

Warning: the svn version might contain some bug-fixes so it can be slightly different from the archive version.

'''Trunk version:''' if you want to try a feature from the trunk version, then run:

||<rowstyle="background-color: #FFFFE0;"> `svn checkout svn://scm.gforge.inria.fr/svn/coq/branches/trunk coq-trunk` ||

Warning: the trunk is ''not'' stable, it might not even compile.



=== Choice of the target folder ===

First, enter the folder that contains the sources. Then, choose among:

'''Global installation (default):''' if you want to install only one version of Coq installed and if you have root priviledges, then do:

||<rowstyle="background-color: #FFFFE0;"> `./configure -opt -prefix /usr/local` ||

'''Local installation:''' if you only want to go for a local installation of Coq (i.e., leaving the binaries in the ./bin folder), then run:

||<rowstyle="background-color: #FFFFE0;"> `./configure -opt -local` ||

After running the configure command, you should be able to read:

||You have GNU Make 3.81. Good! <<BR>>You have Objective-Caml 3.12.2. Good!<<BR>>You have native-code compilation. Good!||

Moreover, if you plan to install CoqIDE, you should be able to read:

|| LablGtk2 found, native threads: native CoqIde will be available.||

It is useless to continue if you don't succeed at this stage.


=== Compilation of Coq and CoqIDE ===

To compile, run:

||<rowstyle="background-color: #FFFFE0;"> `make` ||

If everything works fine, the standard library should compile and then coqide should compile, without errors.

Then, if you used "`-prefix /usr/local`", run 

||<rowstyle="background-color: #FFFFE0;"> `sudo make install` ||

To test the success of the installation, run "`coqc -v`" and "`coqide &`".
If you plan on using CoqIDE, then it is very important that you 
[[Configuration of CoqIDE|fix the key bindings for CoqIDE]].

Otherwise, if you went for a local installation with the option "`-local`", simply 
test the binaries using the commands "`bin/coqc -v`" and "`bin/coqide &`".
