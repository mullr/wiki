Fourth Coq Implementors Workshop, May 28th - June 1st, 2018, Sophia-Antipolis
============================================================================

This page collects useful infos for the participants to the 4th Coq Implementors Workshop.

The Coq Implementors Workshop is an event that brings together the core developers of Coq and people interested in understanding, improving or extending the system.

Location
--------

The Implementors Workshop takes place at University of Nice, Parc Valrose campus, Room M34, France. 

Program
-------

> The schedule will run from Monday afternoon to Friday after lunch.

TBA

Talks by devs:

TBA

PRs to discusss:


Do log what you did/learned/implemented!
---------------------------------------

Write it here

Registration
------------

TBA

Organizers
----------

-   Maxime Dénes (mail at maximedenes.fr)
-   Enrico Tassi (enrico.tassi at inria.fr)
-   Yves Bertot (yves.bertot at inria.fr)
-   Matthieu Sozeau (matthieu.sozeau at inria.fr)

The [coordination mailing list](https://sympa.inria.fr/sympa/info/coq-implementors-workshop) is the preferred channel to contact the organizers.

If you need additional funding, please contact the organizers.

List of participants
--------------------

-   Yves Bertot
-   Maxime Dénès
-   Matthieu Sozeau
-   Enrico Tassi
-   Théo Winterhalter (theo.winterhalter at inria.fr)
-   Ambroise Lafont (ambroise.lafont at inria.fr)
-   Simon Boulier (simon.boulier at inria.fr)
-   Théo Zimmermann
-   Gaëtan Gilbert
-   Loïc Pujet

(+) Late subscription (tradition says you pay a round at the pub...)

Suggestions by New Participants
-------------------------------

Proposed Projects and Ideas
---------------------------

Topics of interest
------------------

**From Jim Fehrle:**
1. People are using Coq to do interesting program verification work, such the DeepSpec project.  However, my impression is that the technique is still too time-consuming/difficult to become widely used in industry.  I'd like to discuss how we could make Coq at least 10 times easier/more efficient to use (measured by user time/effort).  Specifically, I'm interested in ways to make the proof search/discovery process much better.  I'd also like to get an idea of the development effort required and how this might be broken down into a manageable series of tasks.

As someone who is still new to Coq, I want to approach this with appropriate humility--I'd like to learn as much I can about ideas already being considered or implemented.  I have a few ideas of my own that may or may not have merit.  And I expect we want to take good care of current users by providing an appropriate level of compatibility.

As part of this I'd like to learn a lot more about the internals of proofchecking, tactics and LTAC.  (Need to learn LTAC externals, too--haven't had time to see what info is available.)

Secondary, shorter topics:

2. How can we make it easier to learn Coq?  I'd be interested in hearing plans for improving the documentation.

3. How can we make Coq development easier?  I'd like to identify which things are worth doing.  Perhaps some of these:
- internals documentation to make it easier to become a Coq developer and to learn new parts of the system
- unit testing framework (see https://github.com/coq/coq/pull/6808)
- improve OCaml documentation and tools  
= make the OCaml manual more effective for learning/using the language--provide a comprehensive reference, well-indexed, more examples/idioms  
= for debugging, a routine to print a value of any type (if that is possible in OCaml)  
= in ocamldebug, show function names in stack traces  
= look for ways to display stack traces automatically when unexpected exceptions are raised
