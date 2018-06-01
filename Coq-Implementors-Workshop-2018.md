Fourth Coq Implementors Workshop, May 28th - June 1st, 2018, Nice
============================================================================

This page collects useful infos for the participants to the 4th Coq Implementors Workshop.

The Coq Implementors Workshop is an event that brings together the core developers of Coq and people interested in understanding, improving or extending the system.

Location
--------

The Implementors Workshop takes place at University of Nice, Parc Valrose campus, Room M36 (building M, 3rd floor, room 6), France ([campus map](https://www-sop.inria.fr/members/Yves.Bertot/misc/Plan-Campus-Valrose.pdf))

https://goo.gl/maps/YdbdU2MqmUs

Recommended hotels:
- Hotel Monsigny http://hotelmonsignynice.com/fr
- ...

Sponsors
--------
This workshop is sponsored by Inria (travel support for some of the participants) and University of Nice Sophia Antipolis (room for the meeting).

Program (Preliminary)
---------------------

> The schedule will run from Monday afternoon (1pm) to Friday after lunch (~ 2pm).
> There are no organized lunches.

### Monday

- 1pm: Introduction and How To Write A Plugin (see [ybertot/plugin_tutorials](https://github.com/ybertot/plugin_tutorials))
  - Interfacing Coq and ML (building and running)
  - Vernacular Commands, Tactic extensions
  - Reading terms and, crawling the environment (dpdgraph example)
  - Constructing terms, calling typing and unification, inserting definitions
  - Programming Tactics in ML

- Roundtable on user experiences writing plugins/contributing
- Projects descriptions

### Wednesday

- 3pm: Social Event (Museum of Modern Art or Beach depending on weather)
- 8pm: Dinner

### Unscheduled

Talks by devs:

- Writing your plugins in Coq using Template Coq (M. Sozeau, S. Boulier)

Gitter room
-----------

https://gitter.im/coq/CIW2018

Do log what you did/learned/implemented!
---------------------------------------

Write it [here](Coq-Implementors-Workshop-2018-log)

Registration
------------

Registration to this event is free but *mandatory* for organization purposes.  To register you should simply add your name in the list of participants below.

Your e-mail should either be included here(in a human readable form) or sent to coq-implementors-workshop-request@inria.fr

Organizers
----------

-   Maxime Dénes (mail at maximedenes.fr)
-   Yves Bertot (yves.bertot at inria.fr)
-   Matthieu Sozeau (matthieu.sozeau at inria.fr)

The [coordination mailing list](https://sympa.inria.fr/sympa/info/coq-implementors-workshop) is the preferred channel to contact the organizers.

If you need additional funding, please contact the organizers.

List of participants [alphabetical]
--------------------

-   Yves Bertot
-   Simon Boulier (simon.boulier at inria.fr)
-   Cyril Cohen (cyril(dot)cohen(at)inria(dot)fr)
-   Pierre Corbineau (pierre(dot)corbineau(at)univ(dash)grenoble(dash)alpes(dot)fr)
-   Antoine Defourné (antoine.defourne at inria.fr)
-   Frédéric Dabrowski (frederic.dabrowski/at/univ-orleans.fr)
-   Maxime Dénès
-   Jim Fehrle (jfehrle at sbcglobal.net)
-   Yannick Forster (forster (at) ps.uni-saarland.de)
-   [Emilio J. Gallego Arias](https://github.com/ejgallego/)
-   Gaëtan Gilbert
-   Armaël Guéneau (armael.gueneau at inria.fr)
-   Hugo Herbelin
-   Fabian Kunze (kunze at ps.uni-saarland.de)
-   Ambroise Lafont (ambroise.lafont at inria.fr)
-   Vincent Laporte (vlaporte chez imdea point org)
-   Leonidas Lampropoulos (llamp (at) seas.upenn.edu)
-   Erik Martin-Dorel (erik.martin-dorel (at) irit.fr)
-   Thierry Martinez (thierry.martinez at inria.fr)
-   Loïc Pujet
-   Talia Ringer (tringer at cs.washington.edu)
-   José Manuel Rodríguez Caballero (rodriguez_caballero(dot)jose_manuel(at)uqam(dot)ca)
-   Michael Soegtrop (MSoegtropIMC)
-   Matthieu Sozeau
-   Nicolas Tabareau
-   Enrico Tassi
-   Anton Trunov ("anton" dot "a" dot "trunov" at "gmail" dot "com") 
-   Théo Winterhalter (theo.winterhalter at inria.fr)
-   Théo Zimmermann

<!--- Leave this line alone -->
(+) Late subscription (tradition says you pay a round at the pub...)

Suggestions by New Participants
-------------------------------

- By Fabian Kunze: I would be interested in learning more about the internals of Coq and plugin development. Porting [AAC_tactics](https://github.com/coq-contribs/aac-tactics) to coq 8.7 and 8.8 might be a good project, as this plugin seems quite useful. *Matthieu Sozeau*: I would be happy to help you in that endeavor, indeed it is a very useful plugin. It would be good to ask Damien Pous (original author with Thomas Braibant) if he has any intentions regarding it.

- By Michael Soegtrop: I would like to work on a forward proof automation tactic. The idea is to have a tactic which takes a hint database and applies lemmas from the database based on hypothesis in the context until no further lemmas can be forwarded or a maximum expansion depth is reached. First task would be to discuss if the current hint database is appropriate for this as is or would need some extension (I think it is pretty goal centric).

Proposed Projects and Ideas
---------------------------

- Customizing Arguments for bidirectional typechecking (M. Sozeau)

Topics of interest
------------------

- **From Jim Fehrle:**
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

4. It sounds like memory usage may be a limiting factor for some users.  I'd like to understand how Coq uses memory and whether this may be a worthwhile area to look for improvements.

Projects listed on Monday
-------------------------
### Profiling and performance.

(Main contact: Erik)

Documentation, Tutorial and Sample scripts about how to track down performances issues in computations, conversion, unification, etc...

### Custom rewrite tactic `under` for `SSReflect`

(Main contact: Erik)

Adapt a plugin to rewrite under binders in some cases supported by the mathematical components library.
Expose an internal function of `SSReflect` to `ltac`

### Forward Reasoning Automation

(Main contact: Mickael)

`eauto` finds a proof in backward reasoning. We want to do the same the other way around: in forward reasoning.
Depending on the complexity ratio of the premises and the the goal, one or the other might be used.
Currently, the Hint Db is goal oriented, we need another database which is premise oriented.
Hint Db are under-instrumented, we should provide ways to inspect, combine, use, etc...

### Plugin design

(Main contact: Leo)

Write the existing QuickChick plugin in a "better" way, using the "right" data-structures and API.
Port the plugin AAC tactics from 8.6 to 8.8 and add capabilities to rewrite in heterogeneous, associative structures (e.g. Categories).

The goal is not only to improve QuickChick implementation and port ACC, but also to derive a general best practices to write plugins, and maybe a tutorial for middle size to big plugins.

### Equivalences

Do program "ornamenent"-like translations.

### Template Coq

Quoting from within a tactic or within a section (see issues on TemplateCoq GH page)

Achievements listed on Friday
-----------------------------

### plugin tutorial updates

Remarks made during the talks have been taken into account and the master branch of
[this repository](https://github.com/ybertot/plugin_tutorials) is currently consistent
with coq-8.8.  **Future work:** add these tutorials in the coq repository and follow
the evolution of the master branch.

### Forward reasoning automation

We (Armaël, Michael and Théo) identified a primary need to do this kind of automation: having a way to provide non-backtracking hints (because forward reasoning doesn't make sense to be backtracked since it doesn't reduce the provability of the goal, so having these kinds of hints backtracking would only blow up the proof search space for no good reason). We (Armaël and Théo) implemented this capability and did some clean-ups at the same time. A PR is on its way.

**Future work:** generalize the patterns on which to filter hints, add a `Hint Forward` command (to replace the `Hint Extern` that must be used currently for forward reasoning), document this technique in the manual...
