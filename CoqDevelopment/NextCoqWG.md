## page was copied from CoqDevelopment/CoqWG20150915
## page was renamed from CoqDevelopment/NextCoqWG
## page was copied from CoqDevelopment/CRGTCoq20131126
## page was copied from CoqDevelopment/CRGTCoq20130709
<<TableOfContents>>

This page is used to organize the next Coq Working Group (in French GT Coq).
The framadate link to decide which day it will happen was:

  https://framadate.org/2a2xL73ZXlaYpNWK

= Organization =
The next Coq Working Group will take place on February 16th at Sophie Germain, PPS on the 3rd floor.

= Topics for discussion =
 * Development rules and best practices
 * Schedule and roadmap for 8.6
 * Afternoon: Pull requests
 * Discusssion on tactics, ssreflect (minimum 30mns, up to 1h30 if time permits) [HH]

== Talk ==

 * Syntax extension : 'pattern 10 min (Daniel de Rauglaudre)


== Some more possible topics (by Emilio J. Gallego) ==

=== Bugzilla vs other tools? ===

I'm not an expert bugzilla user, but I find for instance GHC's setup a bit more welcoming:

 * https://ghc.haskell.org/trac/ghc/
 * https://phabricator.haskell.org/

In particular I find it easier to:

 * get an overview of the bugs that need most help, that are untriaged, obsolete, etc...
 * understand the roadmap, see what's going to be merged in the next release. (So I can adapt/test against)
 * merge directly from bugs/put link to actual code/commits, etc...
 * comment on commits/branches.
 * do code reviews for patches.
 * personalize the interface.
 * see what others are doing/working on.

I wonder which items can be done with bugzilla setup improvements and which ones are inherently outside the capabilities of the tool.

Regarding github's/gitlab, IMHO their interface currently lacks enough release management tools, so I'm not much of fan (other than for convenience).

Another interesting approach is to have every pull request to go by a mailing list review as done in linux.

=== Splitting the libraries ===

As discussed this summer, would a separate release process for the libraries and for the compiler make sense?

IMHO, this would imply a lot of effort, but on the other hand it could bring significant advantages.

'''GM''' Personally, I think this would be a very good thing. Three reasons: 1) it would likely improve the adoption of opam. 2) it would allow additions to the library without needing to get them merged into Coq. 3), I think it would allow help getting more people involved without Coq development without them needing to work with the Coq internals (yes you can submit pull requests to the standard library without touching the Coq implementation but it seems like a lot). If this gets done, there should be something like a 'batteries' package that packages up some of the most commonly used pieces of the library, in particular, this is probably useful for people where opam does not work well.

'''GM''' One way to see if this would be beneficial would be to poll the community and see how much interest there would be from others in working on this. If no one would want to contribute then it probably is not worth it.

=== coqdoc future ===

What are the plans for CoqDoc? What about supporting writing proof scripts in rich markup languages?

=== Minor points ===

* Coq mailing lists are not indexed by google!
* Should cleanups target master or 8.5?
