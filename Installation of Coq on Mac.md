== Installation from Package managers ==

You can install Coq with Homebrew by simply running

||<rowstyle="background-color: #FFFFE0;"> `brew install coq` ||

or using Mac``Ports by running

||<rowstyle="background-color: #FFFFE0;"> `sudo port install coq` ||
 
You can check that your installation was successful by running `coqc -v`.

The Coq development team will maintain an opam repository for Coq and this will become the preferred way to get Coq on MacOS.

== Create a CoqIDE bundle ==

{{{#!wiki caution
MacOS and gtk move too fast for this section to be up to date. If you try it, you're on your own!
}}}
 * Get Xcode __and__ Command line tools Xcode
 * Get gtk-mac-integration (that require the Quartz backend of gtk) and gtksourceview2 libraries. I used {{{jhbuild}}}. I did
   * {{{ curl -LO  https://git.gnome.org/browse/gtk-osx/plain/gtk-osx-build-setup.sh }}}
   * {{{ sh gtk-osx-build-setup.sh }}}
   * {{{ ~/.local/bin/jhbuild bootstrap }}}
   * {{{ ~/.local/bin/jhbuild build python }}} (used to be necessary, seems OK under 10.10)
   * {{{ ~/.local/bin/jhbuild build meta-gtk-osx-bootstrap }}}
   * {{{ ~/.local/bin/jhbuild build meta-gtk-osx-core }}}
   * {{{ ~/.local/bin/jhbuild build gtksourceview }}}

/!\ This never work on the first time. Get ready to patch gtksourceview (something like [[attachment:fix_gtksourceview.patch]]), download some tar.xz by hand, recall autoconf with extra arguments, ...

 * Get coq OCaml build dependencies (OCaml, camlp5, lablgtk2, lablgtkosx). I did it using opam by
   * Get the opam binary on the opam github page. Put it somewhere on path, give it x rights. Do {{{ opam init }}} and then the command opam asks you to do to config your shell.
   * {{{ ~/.local/bin/jhbuild run opam install lablgtkosx camlp5 }}}
 * Get coq >= v8.5 sources
 * {{{ ~/.local/bin/jhbuild run ./configure -opt -prefix '''whatever''' }}}
 * {{{ ~/.local/bin/jhbuild run make bin/CoqIDE_'''versionfromconfigure.ml'''.app }}}
(./) You've got a CoqIDE (without coqtop so it will asks you for it if you launch it)

 * Add a coq installation in the bundle can be done independently from generating the bundle as long as you use the same version of the OCaml compiler and a coq that speaks the same protocol.

If you've {{{ ./configure -opt -prefix '''somewhere_there_is_nothing''' }}} do 

   * {{{ make -j 4 coq copide-toploop }}}
   * {{{ make install-coq -install-coqide-toploop }}}
   * {{{ ditto '''somewhere_there_is_nothing''' '''correct_path'''/CoqIDE_'''versionfromconfigure.ml'''.app/Contents/Resources/ }}}
   * {{{ codesign -f -s - '''correct_path'''/CoqIDE_'''versionfromconfigure.ml'''.app }}}

== Put an extra package in a CoqIDE bundle ==
 * Get command line tools for Xcode.

/!\ If this is a plugin (containing ml* files), you'll have to be an ocaml compiler compatible with the one used to create the bundle.

 * {{{ export COQBIN='''correct_path'''/CoqIDE_version.app/Contents/Resources/bin/ }}}
 * maybe {{{ ${COQBIN}coq_makefile -f _CoqProject -o Makefile }}}
 * {{{ make -j 2 && make install }}}
 * <!> {{{ codesign -f -s - '''correct_path'''/CoqIDE_version.app }}} <!>
