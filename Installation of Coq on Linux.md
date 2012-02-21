#title Installation of Coq on Linux

== Installation from packages ==

This is the simplest way to get the currently-packaged version of Coq and of an IDE, either CoqIDE or Proof General.

'''Coq'''. To install Coq, open a shell and run the following command: 

||<rowstyle="background-color: #FFFFE0;"> `sudo apt-get install coq` ||

To check that the installation is successful, run the command "`coqc -v`".

'''CoqIDE'''. If you want to use CoqIDE, which is recommended for beginners, run:

||<rowstyle="background-color: #FFFFE0;"> `sudo apt-get install coqide` ||

To check that the installation is successful, run the command "`coqide &`".

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


=== Choice of the target folder ===

'''Global installation:''' if you want to install only one version of Coq installed and if you have root priviledges, then do:

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

Otherwise, if you went for a local installation with the option "`-local`", simply 
test the binaries using the commands "`bin/coqc -v`" and "`bin/coqide &`".
