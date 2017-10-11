This is a partial list of of programming languages projects using Coq.  If we've missed your project please add it, or let us know.

 * Andrew Appel (Princeton): The Concurrent C Minor Project aims to connect machine-verified source programs in sequential and concurrent programming languages to machine-verified optimizing compilers.  [[http://www.cs.princeton.edu/~appel/cminor/]]

 * Mike Hicks (U. Maryland): We've just gotten a paper accepted to TPHOLs that uses Coq to prove the soundness of our POPL result: [[http://www.cs.umd.edu/~mwh/papers/pratikakis08context.html]] Polyvios Pratikakis used the PLClub's metatheory library for this.  We are also working on formalizing some of the proofs for SELinks, ultimately to create a framework for establishing the correctness of various security policy implementations.  There is no information available on this at the moment, but the project page is [[http://www.cs.umd.edu/projects/PL/selinks]].

 * Greg Morrisett (Harvard): The Ynot project (see [[http://www.eecs.harvard.edu/~greg/ynot]]) is using Coq, or more properly, extending Coq with support for writing and extracting programs directly in the language. The Rock``Salt project is using Coq for Software-based fault isolation for the x86, as described in a PLDI'14 paper (see [[http://dl.acm.org/citation.cfm?id=2254111]]).

 * Zhong Shao (Yale): Starting from our POPL'02 paper on "a type system for certified binaries", we have been applying the Coq proof assistant to formally reason about low-level programs.  This includes work on typed intermediate languages, proof-carrying code, and a large number of program logics for certified assembly programming. We have also used Coq to certify various components of low-level systems software including the OS bootloader, garbage collectors, memory management libraries, thread implementation, and context switching and synchronization primitives. See the FLINT group page [[http://flint.cs.yale.edu]].

 * Dan Grossman (U. Washington): In our recent ICFP submission on transactional events for ML, Laura Effinger-Dean used Coq to formalize/confirm the equivalence between a high-level nondeterministic semantics and a low-level (more) deterministic semantics.  See: [[http://wasp.cs.washington.edu/tecaml/]] which includes Laura's Coq code.

 * Andrew Kennedy (Microsoft Research): I'm using Coq to formalize the extensional semantics of polymorphic units-of-measure types, with the goal of generalizing the results of my POPL'97 paper on "Relational Parametricity for Units of Measure".  No URL just yet (though [[http://research.microsoft.com/~akenn/units]] has the original work).

 * Adam Chlipala: I'm using Coq to build certified compilers for statically-typed functional languages.  A key part of this is my Lambda Tamer library:  [[http://ltamer.sourceforge.net]].  I hope to have a certified compiler from core ML to TAL in the foreseeable future.

 * Christopher Dutchyn (U. Saskatchewan): I'm working on formalizing AOP languages translating my dissertation and collaborations with Wand, Kiczales, and Masuhara into Coq.

 * Geoffrey Washburn (EPFL): The current plan is that I will formalize the new version of Featherweight Scala using Coq, though I am only just starting, so it is possible I may become frustrated enough with the craziness concerning induction principles that I will retreat to Twelf. 

 * Pierre Castéran (LABRI): Designing a programming language for describing and proving some schemes of distributed algorithms. The language must describe local computations on undirected lablelled graphs, following a formalism developped by Mazurkiewicz, Metivier, Mosbah et al. Coq and Why will be used to prove properties of programs and classes of programs, included impossibility results.

 * Edsko de Vries (Trinity College): My PhD thesis involves the design of a simplified uniqueness (substructal) type system. I'm using Coq and the "Engineering Formal Metatheory" approach to formalize the system. So far, I have proved soundness (progress and type preservation), a non-trivial property in this case. I'm also planning to prove properties such as principal types (Hindley/Milner style). More information can be found at [[http://www.cs.tcd.ie/~devriese/pub]]

 * Xavier Leroy (INRIA with CNAM and PPS):  Dr. Leroy is working on Compcert, a realistic compiler for a subset of the C language, programmed and proved correct in Coq.  Includes formalizations of operational semantics for the Clight subset of C and a number of intermediate languages, as well as Coq proofs of semantic preservation for a number of compiler-like program transformations.  (See [[http://compcert.inria.fr/]]).

 * Jeff Vaughan (U Pennsylvania):  Limin Jia, with Steve Zdancewic, Karl Masurak, and myself, used Coq to formalize the soundness of Aura, a security-oriented, dependently-typed language [[http://www.cis.upenn.edu/%7Estevez/sol/aura.html]].  Additionally I have been formalizing the Dual Calculus in Coq.

 * Nick Benton (Microsoft Research): I'm using Coq for formalizing and verifying relational specifications for low-level programs, including handcrafted memory managers and the output of certified compilers. Vassilis Koutavas has formalized some work we did on bisimulation for the nu calculus (using the UPenn metatheory library). I've also proved some results about the semantics of effect systems.

 * Kenn Knowles (UCSC): We are in the process of formalizing Velodrome [[http://www.soe.ucsc.edu/~cormac/papers/pldi08.pdf]], a dynamic atomicity analysis which is sound and complete with respect to a given program trace.  This involves a formalization of an interleaving semantics, the happens-before relation, serializability, commutation of operations, etc. This is joint work with Cormac Flanagan, Caitlin Sadowski, Stephen Freund, and Jaeheon Y

 * Moez A. Abdel-Gawad (Rice University): I'm using Coq to formalize Domain Theory, as in Cartwright and Parsons's 'Domain Theory: An Introduction' monograph, based upon which I intend to build a domain-theoretic model of nominal OOP (e.g., Java, C#, Scala, ... etc), and prove (also using Coq) certain properties of this model (and, accordingly, certain properties of nominal OO languages).

 * Ben Lippmeier (UNSW): Maintains Iron Lambda [[http://iron.ouroborus.net/]], a collection of Coq formalisations of functional languages of increasing complexity.

 * Java Card EAL7 certification in 2007 at Gemalto [[http://www.gemalto.com/php/pr_view.php?id=239]].

 * The JSCert team (Imperial College London & INRIA): We have formalized the semantics of Java``Script (ECMAScript 5) in Coq, and extracted a trusted reference interpreter for the langauge, as described in our POPL'14 paper ([[http://dl.acm.org/citation.cfm?id=2535876]]). Our development is available online, please use it and/or contribute: [[http://jscert.org]], [[https://github.com/jscert/jscert]].

 * Kia Rahmani (Purdue University): I am using Coq to formalize Quelea, a declarative programming language over eventually consistent data stores [[http://gowthamk.github.io/docs/quelea.pdf]].

 * Abhishek Anand (Cornell University): I have developed [[https://github.com/aa755/ROSCoq|ROSCoq]], a framework for developing and reasoning about robotic programs in Coq. ROSCoq comes with facilities for running these programs on robots supported by the Robot Operating System  [[http://www.ros.org/|(ROS)]]. This is achieved by using Coq's extraction to Haskell, and then using the [[https://github.com/acowley/roshask|roshask]] library.
 
