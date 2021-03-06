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

We (Armaël, Michael and Théo) identified a primary need to do this kind of automation: having a way to provide non-backtracking hints (because forward reasoning doesn't make sense to be backtracked since it doesn't reduce the provability of the goal, so having these kinds of hints backtracking would only blow up the proof search space for no good reason). We (Armaël and Théo) implemented this capability and did some clean-ups at the same time. A PR has been submitted (#7661).

**Future work:** generalize the patterns on which to filter hints, add a `Hint Forward` command (to replace the `Hint Extern` that must be used currently for forward reasoning), document this technique in the manual...

### Plugin design

We (Leo and Talia) both updated plugins to use the latest Coq version. I (Talia) addressed several bugs in my plugin that I did not understand before talking to the Coq developers (for example, dealing with universe constraints and refreshing environments after defining terms).

**Future work:** We should make the Plugin Developer Program that Emilio proposed a reality. In addition, I (Talia) will make a list at some point of the functionality I have in my plugin so that other people can access it, and I will update my own plugin tutorials to the latest Coq and use best practices (I'll be in touch about this at some point).

### Equivalences

We (Talia, Cyril, Matthieu, Nicolas, Enrico) had several productive meetings about ornaments, refinements, and equivalences, figuring out how these projects unify conceptually and where they diverge. In doing so, we identified several places where work from one of our tools (for example, search) may be useful for other tools. 

**Future work:** Collaborate more so that we can actually reuse these concepts across tools. Also, I (Talia) will be in touch with Cyril and Enrico in the future about the possibility of porting infrastructure.

### AAC tactics

I (Fabian) ported the plugin AAC_tactics (containing tactics for rewriting up to associative/associative-commutative operations) to 8.7 and 8.8. I learned a lot about ocaml, the build process of coq and plugins, and about how to interface with coq inside a plugin.

I am in the process to extend the plugin with an aac_apply tactic, the application of lemmas modulo A or AC. This would enable e.g. to simplify a goal containing of a large inequation of sums 'x+c+y <= c+z' to 'x+y<=z' using the lemma 'forall x y c, x <= y -> x + c <= y + c'. For that, I extend the reflection and ocaml-part to enable reasoning about terms containing several types (aac_tactics currently only works with exactly one carrier type, but my example involve e.g. Prop and nat).

**Future Work:** Complete the aac_apply, a step towards rewriting modulo associativity with heterogeneous, associative operands as function composition or composition of arrows in category theory.

### Template Coq

I (Yannick) fixed several bugs: Unquoting terms now shows an error (instead of raising an anomaly) if an ill-typed term is unquoted (PR #39), fixed the easy tactic in the development (PR #41) and fixed the treatment of implicit arguments in `tmLemma` (PR #45). I also implemented `tmExistingInstance` to register instances (PR #43), implemented `tmInferInstance` to infer an existing instance for a class (PR #44), added an `unfold` option to `tmEval` (PR #40) and made the reduction strategy used for the type of definitions customizable (PR #42).

Simon ported Template Coq to the current master branch of Coq.

**Future Work**: I (Yannick) have to port my PRs (currently filed against the 8.7 branch) to the master branch.

### 'have' tactic

I (Frédéric) started writing the 'have' tactics which behaves like the 'assert' tactics but permits to clear the proof environment to improve readability. It is also possible to introduce intermediate results that are expected to be proved automatically by eauto.
In 'have t from H1 ... Hn, P1 ... Pn', t is the assertion to prove, the Hi are the hypothesis and the Pi are the intermediate results. As suggested by other participants I plan to add the possibility to use hint databases for improving the experience with intermediate results.
The tactic has been fully written in ocaml. As a complete beginner with Coq's internals, this was a greet and rewardable experience. 

### Agda-like rewrite rules
I (Ambroise) started to think about how to add rewrite rules in Coq, i.e. reductions rules in the conversion specified by the user of the form 'forall (x1 : A1) ... (xn : An), C y1 .. yp (D z1 .. zq) = t' where yi, zi are variables or holes. C and D are opaque constants or constructors.
I successfully modified the kernel head normalization algorithm for a single example (the reduction rule for K), though I did not extensevely checked whether I introduced new bugs. I am thinking of using template Coq to write a plugin that allows to introduce new reduction rules that would use this new feature of the kernel.

### Profiling computation in Coq
I (Erik) was strongly interested in studying ways to profile computations in Coq (such as when using `vm_compute` or `native_compute` in a reflexive tactic), and Maxime pointed out to me that there already exists one such feature for `native_compute`. We did a few experiments to try it, but actually identified two blocking bugs that I reported on the issues tracker: [#7631](https://github.com/coq/coq/issues/7631) − already fixed in [PR #7643](https://github.com/coq/coq/pull/7643) − and [#7673](https://github.com/coq/coq/issues/7673).

Also, beyond `vm_compute`/`native_compute`, Enrico started writing a page [ProfilingCoq](https://github.com/coq/coq/wiki/ProfilingCoq) with a wrap-up of the various layers that may have an impact on the performances of Coq in general.

### New implementation of a tactic `under` for `SSReflect`
I (Erik) started with Enrico a new re-implementation of the `under` tactic ([a previous implementation](https://github.com/erikmd/ssr-under-tac) of which was in pure Ltac and was not as generic as the `rewrite` tactic in terms of contextual patterns and occurrence selectors). After several discussions with Cyril and Enrico, we devised a new specification of the tactic with a more generic and more ssr-friendly syntax. In particular, in addition to a one-liner, immediate proof mode, an interactive mode should be available when doing:
```coq
under i: eq_bigr.
  (* ... *)
  by rewrite addnC; over.
```
Enrico and I (Erik) made some progress in implementing this in ML+Gallina during the week, but the work is still on-going.