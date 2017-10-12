Discussion on the standard library of Coq
=========================================

See also [StandardLibrary](StandardLibrary) for older discussion (should these pages be merged?)

Organisational aspects
----------------------

### Overall consistency and maintenance

-   Lack of overall design consistency due to not-always-coordinated multi-author development through different times of the history of Coq.
-   Lack of human resources for a correct maintenance of many components of the library:
    -   many users propose to complete and extend some libraries but no availability from the development team to evaluate these additions and to check these extensions do not add design inconsistencies to the existing setting \[Comment by HH: tentative guidelines are available [here](HowToContributeToTheStandardLibrary) with the objective of making easier the work of evaluation and integration of user's contributions\].
    -   many users developed libraries that could be considered of general purpose ([UserContributions](UserContributions)) but, again, the Coq developers do not have the time to referee and validate these libraries.

Possible solution: A more modular approach of libraries with a small core of standard library maintained by the Coq development team and a second distinct distributed archive of libraries with a coordinated maintenance so as, not to necessarily guarantee a strict overall consistent design, but to at least guarantee correct compilation dependencies (see the [MathWiki](http://prover.cs.ru.nl/wiki.php) project). The responsibility of the maintenance of the consistency of each individual component of this second archive would be distributed.

From the [StandardLibrary](StandardLibrary) page:

-   Easy-to-contribute library is much better. Although we should keep library clean and strict we should allow user to contribute in even small part. Nobody will write thousands lines of code before contribution. If every ten lines can be submitted, then we'll have much more active and wide community. \[Comment by HH: how to ensure design consistency? Official guidelines to follow? Who takes the responsability of the integration? Set up of a user-contributor group?\]
-   There should be clean list of common problems defined in both existing and to-be-written code. One should be able to easily find the problem and solve it. (See [ProjectIdeas](ProjectIdeas)?)

### Compatibility issues

-   Compatibility issues hinder or at least complicate the improvement of some libraries, e.g.:
    -   definitions or lemmas got inconsistent names, e.g.:
        -   `_symm` vs `_sym`, `le_n` vs `le_refl`, ...),
        -   `plus`/`mult` instead of `plus`/`times` or `add`/`mult` or `add`/`mul`,
        -   very basic lemmas such as `n = pred (S n)` were stated in an unnatural way (this historically was due to the use of *elim* for simulating rewriting before *rewrite* was implemented),
    -   bound variables sometimes got inconsistent names in a same library (e.g. lemmas on nat generally use n, m, p, q in this order, but sometimes, it is a,b or x, y or the differently ordered m, n),
    -   hints database cannot be improved without breaking *auto* in general.
    -   bad definition choices were sometimes made (e.g. `Zplus` of numbers of opposite signs which uselessly computes twice the difference, or the questioned design of &lt;=, &lt;, &gt;= and &gt;),
    -   lemmas not always stated on their optimal generality (useless or arbitrarily weak side-conditions).
-   How to address the compatibility issues?
    -   Completely forget about too inconsistently built libraries? But they will still be needed anyway. And with what to replace them?
    -   Use mechanisms as in the V7 to V8 translator?
        -   Notations to provide only-parsing compatibility aliases to newly consistently-named lemmas?
        -   ML support for on the fly renaming of binders?
        -   Eventually arrive at a V9 generation and use a translator?
        -   Combine the cleaner parts with parts clearly flagged as obsolete?

### Lack of Coq support for features

-   Dependency of the technical design of the libraries over the support (or absence of support!) of Coq for some features, e.g.:
    -   lack of support for freely reasoning with less-or-equal or greater-or-equal as one would do in a mathematical text: either one is a notation for the other and then the user cannot choose which one he wants to read, or there are two distinct definitions but then there are often not converted one to the other by Coq,
    -   lack of support for freely switching between a computational representation of decidable properties (as order in `ZArith` is defined) and a propositional representation of it (as order in `Arith` is defined),
    -   automatic introduction of names and hypotheses in the context?

### Documentation and metadata issues

Coqdoc is a rather nice tool for documentation but there is a need for metadatas liable to ease the formal treatment of informations like title, author, table of contents, ...

Specific issues with the libraries of Coq
-----------------------------------------

### Arithmetic

#### General issues about arithmetic

-   Naming policy:
    -   `_n_0` style vs `_0_r` style?
    -   Heterogenous pair `plus`/`mult` (with adopted solution being the pair `add`/`mul`)?
-   Design choice for less vs greater:
    -   Have explicit constants for &gt; and &gt;= (better for displaying things as the user did but requires better support for such "notational" definitions)?
    -   Have only &lt; and &lt;= what is easier to manage and mathematically "cleaner" to think about?
-   Notation policy:
    -   Adopt the nice `.+1` notation?
    -   Use "\_ = \_ ?", "\_ &lt;= \_ ?" for the computational operations?
-   What design choices for orders and decidable predicates?
-   Design choice for decidable operations:
    -   Decidability to `bool` or decidability to `sumbool` (but then requires better support for rewriting modulo proof-irrelevance)?
-   Modularity:
    -   Proceed further with the `Numbers` modular approach?

#### Peano numbers

-   Organisation:
    -   One large file vs small files (as it is now)?
    -   What to put in `Init`? Just the operations or also the basic lemmas?
    -   Make all non basic lemmas derived from `Numbers`?

#### Binary natural numbers

#### Binary integers

#### Rational numbers

### Real numbers

### Lists

-   How to deal with partial functions: by returning a default element, by returning an option type, by guarding the definition with a precondition?

### Lists annotated with their length (vectors)

Coq provides a single file with a few results (with comments in French) in the [Bool](http://logical.saclay.inria.fr/coq/distrib/current/stdlib/Coq.Bool.Bvector.html) library. The [CoLoR](http://color.inria.fr) contribution provides much more.

### Boolean

### Strings

-   Add a function to interpret C-style strings (using for escaping).
-   Add a primitive function `print : string -> unit` (or `: forall A, string -> A -> A` natively interpreted at evaluation time as a side-effect on the standard output.

### Logic

There should be a module for extensional equality for functions (see the axiom of functional extensionality declared in `Coq.Program.FunctionalExtensionality`).

### Sorting

Is this worth to be a distinct library?

### Maps and sets (data structures)

### Relations and sets

-   The `Coq.Sets.Relations_`\* modules duplicate the theory of relations provided by `Coq.Relations.Relations`, with different theorems following from each.
-   Now that nested directories are being supported for theories/Numbers, the `Wellfounded` directory should probably be moved under `Relations` for clarity, as it was in Coq 6.x.

### Unexploited content of the support for tactics (ring, ...)

### Algebra

Coq sparsely provides definitions of algebraic structures but to which extend is this usable as a standard library? Many approaches to algebra exist (see the various Algebra contributions in the [user contribution server of Coq](http://logical.saclay.inria.fr/coq/distrib/current/contribs), including C-CoRN).

### Libraries not represented in Coq

Libraries on these topics exist:

-   Floating point numbers ([IEEE754](http://logical.saclay.inria.fr/coq/distrib/current/contribs/IEEE754.html), [fp2](http://lipforge.ens-lyon.fr/www/pff))
-   Constructive real analysis (computing and mathematical aspects, see e.g. [ExactRealArithmetic](http://logical.saclay.inria.fr/coq/distrib/current/contribs/ExactRealArithmetic.html), [CoinductiveReals](http://logical.saclay.inria.fr/coq/distrib/current/contribs/CoinductiveReals.html), [CoRN](http://c-corn.cs.ru.nl), interval arithmetic, ...)
-   Finite sets (either [InductiveFiniteTypes](InductiveFiniteTypes) or [FixpointFiniteTypes](FixpointFiniteTypes) would be reasonable candidates for inclusion in the standard library, there is also a library by Jean-François Monin).

What about the licence issues?
