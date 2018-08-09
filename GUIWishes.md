Wish list for graphical user interfaces
=======================================

See also [CoqIDEWishes](CoqIDEWishes).

Please complete or add comments or add stars "\*" to vote for features.

Miscellaneous features
----------------------

-   Proof-by-pointing features (Pcoq's spirit) using right-clic:
    -   right-clicking on constants would propose "unfold",
    -   moving equality statements in hypothesis to goal or other hypothesis with a left or right move would rewrite the given hypothesis,
    -   selection of subterms by clicking on main symbol or by full selecting?
    -   ability to mark hypotheses to which the next induction will apply
    -   ...
-   Support for easy goal switching?
-   Use tab to indent proofs
-   A graphical advanced search windows for driving `SearchAbout`.
-   Support for easy selection of structural features (definitions, terms, subterms, identifiers...)?
    -   could be a separate view (see below)
    -   pcoq can do this
    -   Alfa (agda1) also does this: it's deeply integrated with its natural language support.
-   Support for queries by right-clicking constants or selected expressions? what about a tooltip (if you keep the pointer on a constant more than 3 seconds, it displays its type, definitions...)
-   Key or right-click for making explicit hidden information (coercions, implicit arguments, notations, ...) on selected subterms.
-   Automatically expand unnamed intros into intros with explicit names
-   Automatically compile .v if necessary when 'Require' are evaluated
-   Allow partial evaluation of ; sequences as in Matita : for example evaluating only T1;T2 in the sequence T1;T2;T3 without writing T1;T2. T3.
    -   could be a switchable option, useful for debugging complex proof scripts.
    -   what about other tacticals?
-   Reflect the tree structure of the proof into a tree widget to allow hiding parts of the proof.
    -   most procedural proof scripts don't have much of a tree structure. does this apply to proof-terms, declarative proofs or what?
-   Support for natural language explanations in proofs?
    -   useful for beginners
    -   coq 6.\* and pcoq had this
    -   alfa integrated this with support for 2D views
    -   declarative proofs may make this unnecessary
        -   but need some means of converting from proof terms (Matita does this) or procedural proof scripts
    -   drawback: full natural-language proofs quickly become overwhelming
        -   Alfa supports hybrid representation: use symbols for low-level manipulation, natlang for the higher-level structure

Graphical notations
-------------------

-   Support for 2-dimension notations?
    -   pcoq and alfa/agda1 have some support for this
    -   as a convention, every notation of the form ^\* could be written as an exponent and every part of an ident ended by \_digits or

Links
-----

-   Diagram representation in [Penrose](http://www.penrose.ink/)
-   Structured editing in [Deuce](https://arxiv.org/abs/1707.00015)
-   The [SerAPI](https://github.com/ejgallego/coq-serapi) library for machine-to-machine interaction with Coq