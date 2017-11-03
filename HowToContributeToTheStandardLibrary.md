How to contribute to the Coq standard library
=============================================

Updates or fixes to existing Coq library are welcome. Please follow the guidelines below as much as possible. Contributions can be submitted to the coqdev mailing list (coqdev at inria dot fr) or to the [bug tracker](http://coq.inria.fr/bugs). Please take into consideration that developers are generally researchers working only part time on Coq and that response delays may vary from hours to weeks. If delays exceed months, feel free to contact the developers again.

Contributors should accept to have their contribution licensed with the same licence as Coq standard library, i.e. [LGLP 2.0](http://www.gnu.org/licenses/old-licenses/lgpl-2.0.html).

Contributions of stand-alone libraries should be done at the [Coq user contributions repository](http://coq.inria.fr/pylons/contribs/new).

The Coq library guidelines
==========================

*Warning: this at the current stage only a proposal, comments are welcome (this is a wiki)*

Unfortunately, the Coq library is far from being [homogeneously](ReflectionOnStandardLibrary) written. Also, the language of Coq itself, especially regarding tactics, often presents some idiosynchrasies that do not help in designing clean libraries. Nevertheless, the following guidelines seem to be generally accepted. Don't hesitate to add examples or remarks on this page (it is a wiki whoever can contribute to!). If the remarks lead to a discussion thread, some synthesis will be done after a while by the administrators.

General guidelines
------------------

-   Follow the style of the modified/extended library as much as possible

    > Coq libraries have been developed by several different persons and it is not always clear what the style of a given library is. In this case, follow what seems to you the most consensual or best style and shortly explain your choice while sending your code

-   For standard mathematical properties (such as commutativity, associativity, ...), follow the recommendations from the file dev/doc/naming-conventions.tex of the distribution for naming lemmas and for canonically ordering the arguments and hypotheses of the lemmas.
-   For properties that do no have standard name, follows the style of the modified library. Typical conventions that several libraries follow (but not all) are:
    -   Use of glued words with capital initial letters for predicates and module names; use lowercase words separated by underscore for functions (e.g., in library `List`, `In`, `NoDup` and `Exists` are predicates, while `last` and `rev` are functions.
-   Start every proof by the keyword `Proof`, end them with `Qed` or `Defined` depending on whether the lemma has to be used in computation or not. Align `Proof`, `Qed}} and {{{Defined` with the line stating the lemma. Starts the proof after an extra indentation of 2 characters.
-   Formatting: Coq's terms and statements should be formatted as the Coq pretty-printer formats them. For instance, cases of an inductive type declaration and of pattern-matching constructs should be aligned vertically unless the whole definition is less than 80 characters long. Also, all symbols, to the exception of delimiters, should be separated from other expressions by spaces. Even though English typography recommends no space before a colon, one has to put one in Coq files. In short, the submitted contribution should look like if it has been formatted by the option `--beautify` of `coqc`. *Contributions to the standard library that do not follow the standard formatting will not be considered*.

Tactics guidelines
------------------

The following recommendations apply even if the library being extended do not follow them.

-   Give a name to all hypotheses that are referred to later on in the script whenever the tactics used permit do to so.
-   Do not use deprecated tactics:
    -   `elimtype`: most usages of it can be replaced `exfalso`
    -   `legacy ring`: use `ring`
    -   `legacy field`: use `field`
-   Specific tactics
    -   Case analysis, induction and inversion
        -   There is an overlapping between what `case`, `destruct`, `dependent destruction` and `inversion` do and all them should eventually merge into a unique tactic. There are several tastes: the *in-place* style supported by `destruct` and the *push-on-goal* style supported by `case`. The in-place style recommends to use `destruct`, `dependent destruction`, `inversion` and `case`, in this preference order (in particular `inversion` is not considered to be robust and predictable enough).
        -   There is an overlapping between what `elim`, `induction` and `dependent induction` do and they should eventually merge into a unique tactic. In the meantime, the in-place style recommends to use `induction`, `dependent induction` and `elim` in this order.
        -   Indent the different cases of an induction step at the same level. If most of the cases need several lines, separate cases by a blank line and use comments to make explicit which case it is.
    -   Automation
        -   `auto`/`eauto`: use the `using` clause as much as possible whenever it underlines the use of an important lemma for the proof.
        -   Linear arithmetic: there is an overlapping between what `omega`, `romega` and `lia` do. In any cases, avoid `romega`; `lia}} is complete and generally faster but {{{omega` is better able to deal with non primitive symbols (`max`, `min`, natural numbers, ...).
    -   The `now` tactical, similar to the `by` tactical of the ssreflect language, allows to ensure that the tactic coming next solves the goal up to the use of some simple automation tactic called `easy` (similar to `done` in ssreflect). The exact strenght to give to `easy` is still under discussion. Nevertheless, in long proofs, using `now` improves the robustness of the script and is thus good practice.
    -   `double induction` is most often better replaced by `induction ...; destruct ...`
    -   Prefer `revert` to `generalize`.
    -   Chaining: chain successive applications of `apply`, `rewrite` as much as possible using the comma.

*To be continued*

Documentation
-------------

New lemmas or definitions should be accompanied with a coqdoc-compliant header, even though most of the current library fails to follow this recommendation.

Use of notations and unicode symbols
------------------------------------

-   For all notations, do as much as possible notations which when printed can be parsed (for instance, avoid `Notation "!" := (f _).`); so that copying/pasting from a result coq buffer to a coq input buffer will be parsable.
    -   For Utf-8 notations, consider putting them in a separate module and providing Ascii notations by default, so that the user who doesn't support displaying Utf-8 characters should simply not open your utf8 module, and the user who can output them but not input them, can use ascii notations for input and utf8 notations for output (and of course the user who fully support utf8 can use it for both input and output). If your module is called, `Foo`, then your UTF-8 module should be called `FooUtf8` and its content should be `Require Export Foo.` followed by a sequence of (utf8) notations.

*Section to be expanded*
