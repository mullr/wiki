Page to sum up the discussions about OPAM.  It may be incomplete.  Feel free to fill in but please don't change the structure of the page that is meant to drive discussion.

= Problems of today we want to solve via a package manager =
This are problems encountered by the Coq users and developers we want to tackle, not problems of OPAM in one of its declinations.
I take the freedom to rank problems into the more urgent, and the ones I (Enrico) consider less urgent (no matter if a solution for one is also a solution for another).

 1. regular user installing Coq.

   I don't think it applies to a developer, since we know what we are doing.  Unfortunately even people using Debian or derivatives regularly need a version of Coq, even a stable one, not packaged. Not a problem for OSX or Windows (in principle you have an official bundle).

 1. regular user installing an ml extension of Coq.  

   This problem affects all users.  If one is lucky the bundle (as above) ships all the files needed in order to compile the extension (will be the sase in 8.5 for windows, don't know for mac), but compilation can still fail in many ways (upgrade of OCaml between Coq and plugin compilation, wrong paths or env variables).

 1. people distributing extensions.  

   One can bundle/precompile them for OSX or Window, but this is an effort (e.g. you need a Mac/Windows machine).  No bundle for Linux.

 1. dependency resolution in testing.

   Today hard coded in the bench system.

== Maybe problems in the (near) future, desiderata, commodities ==

 1. extensions depending on extensions depending on extensions...

   There are a few already.  "Soon" ssreflect will be fragmented into ~ 10 smaller libraries.

 1. standardize the way one distributes/installs an extension (ml or not) for Coq.

 1. distributing the contribs that are not alive (the one alive are distributed by their authors using the same mechanism)

 1. an opam root always bundles an ocaml compiler and this helps setting up native_compute (it just works)

= The tool =
OPAM, what offers and at which price.  

=== good ===

 1. clean environment compatible with OCaml's idiosyncrasies (same version of the compiler for all linked files) and Coq's (same coqtop binary for all .cmxs and .vo linked)
 1. handling dependencies between coq and extensions
 1. low cost of packaging (especially extensions built using coq_makefile)

=== bad ===
 
 1. a new tool for (some) users, especially the less technically inclined
 1. complexity of dependency management exposed to the user
 1. compilation time
 1. not for windows (not in time for 8.5, maybe later)
 1. not a complete toolchain (the C compiler needs to be in any case installed in the host system for .ml plugins)

=== opinions: should we adopt it? ===

 1. Enrico: no real alternative tool (esp. handling the specificities of ocaml); complexity for the user can be lowered in many ways (extra work, but possible); compilation time not a problem for the regular user (a regular user does not install coq every day).  In short the problems it solves are more than the ones it creates (assuming we use opam >= 1.2, lower versions are too broken).

= Proposals so far =
Things that have been proposed, some of them already implemented

 1. All extensions' versions for various coq versions in the same coq repo (repo-stable)

    * PROS: 1 repo to add to opam to access everything

    * CONS: quite some complexity for the beginner.  (e.g. you see packages you can't install without changing Coq version)

    * CONS: the coq package is not under our direct control.  (updates via pull requests to be accepted by non-coq people)

 good documentation could clearly help the beginner.  maybe we could get commit rights in the opam official repo.

 1. A repo for Coq version X, containing also the right Coq version

    * PROS: the user only sees a consistent set of packages for his coq version

    * CONS: the coq package is already in the opam standard repo, and some packages depend on it (why3)

 maybe we could have coq both on the official repo and in our repo, but have on our side a coq version with a higher version number to "shadow" the official one if needed.

 1. Embedding opam in Coq

    * PROS: max flexibility, we can hack it

    * CONS: like maintaining a fork

    * CONS: no code yet, not trivial

 1. A specific wrapper for Coq around opam

    * PROS: max flexibility

    * CONS: no code yet, how do we install the wrapper?

=== related proposals ===

 1. The OSX bundle includes also an opam root

    * PROS: best of both worlds (pre compiled environment, extensible via opam)
 
    * CONS: a .app/ directory is read only and .opam/ roots are not relocatable

    Enrico: I think the following "hack" is worth trying  The bundled OPAM root is built in /Library/coq-$VERSION/opam (i.e. a dir not depending on the user name); such root is then shipped as a .tgz inside the .app bundle; the startup script in the .app/ bundle untars ([[http://stackoverflow.com/questions/1517183/is-there-any-graphical-sudo-for-mac-os-x|using sudo]]) the opam root if not already there and starts coq from the opam root (eval `opam config env`; coqide).  The user willing to add opam packages jumps to /Library/coq-$VERSION/opam and calls opam via sudo.  The drawback is that one has, in the .app/ a tarball that uses some space (but also allows one to restart from scratch by erasing the dir in /Library).
