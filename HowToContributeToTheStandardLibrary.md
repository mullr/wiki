= How to contribute to the Coq standard library =

Updates or fixes to existing Coq library are welcome. Please follow the guidelines below as much as possible. Contributions can be submitted to the coqdev mailing list (coqdev at inria dot fr) or to the [[http://coq.inria.fr/bugs Coq|bug tracker]]. Please take into consideration that developers are generally researchers working only part time on Coq and that response delays may vary from hours to weeks. If delays exceed months, feel free to contact the developers again.

Contributors should accept to have their contribution licensed with the same licence as Coq standard library, i.e. [[http://www.gnu.org/licenses/old-licenses/lgpl-2.0.html|LGLP 2.0]].

Contributions of stand-alone libraries should be done at the [[http://coq.inria.fr/pylons/contribs/new|Coq user contributions repository]].

= The Coq library guidelines =

Unfortunately, the Coq library is far from being [[ReflectionOnStandardLibrary|homogeneously]] written. Also, the language of Coq itself, especially regarding tactics, often presents some idiosynchrasies that do not help in designing clean libraries. Nevertheless, the following guidelines seem to be generally accepted. Don't hesitate to add examples or remarks on this page (it is a wiki whoever can contribute to!). If the remarks lead to a discussion thread, some synthesis will be done after a while by the administrators.

== General guidelines ==

 * Follow the style of the modified/extended library as much as possible

   Coq libraries have been developed by several different persons and it is not always clear what the style of a given library is. In this case, follow what seems to you the most consensual or best style and shortly explain your choice while sending your code

 * For standard mathematical properties (such as commutativity, associativity, ...), follow the recommendations from the file dev/doc/naming-conventions.tex of the distribution for naming lemmas and for canonically ordering the arguments and hypotheses of the lemmas.

 * For properties that do no have standard name, follows the style of the modified library. Typical conventions that several libraries follow (but not all) are:

   * Use of glued words with capital initial letters for predicates and module names; use lowercase words separated by underscore for functions (e.g., in library {{{List}}}, {{{In}}}, {{{NoDup}}} and {{{Exists}}} are predicates, while {{{last}}} and {{{rev}}} are functions.

 * Start every proof by the keyword {{{Proof}}}, end them with {{{Qed}}} or {{{Defined}}} depending on whether the lemma has to be used in computation or not. Align {{{Proof}}}, {{{Qed}} and {{{Defined}}} with the line stating the lemma. Starts the proof after an extra indentation of 2 characters.

 * Formatting: Coq's terms and statements should be formatted as the Coq pretty-printer formats them. For instance, cases of an inductive type declaration and of pattern-matching constructs should be aligned vertically unless the whole definition is less than 80 characters long. Also, all symbols, to the exception of delimiters, should be separated from other expressions by spaces. Even though English typography recommends no space before a colon, one has to put one in Coq files. In short, the submitted contribution should look like if it has been formatted by the option {{{--beautify}}} of {{{coqc}}}.

== Tactics guidelines ==

The following recommendations apply even if the library being extended do not follow them.

 * Give a name to all hypotheses that are referred to later on in the script whenever the tactics used permit do to so.

 * Do not use deprecated tactics:

   * {{{elimtype}}}: most usages of it can be replaced {{{exfalso}}}
   * {{{legacy ring}}}: use {{{ring}}}
   * {{{legacy field}}}: use {{{field}}}

 * Specific tactics

   * Case analysis, induction and inversion

     * There is an overlapping between what {{{case}}}, {{{destruct}}}, {{{dependent destruction}}} and {{{inversion}}} do and all them should eventually merge into a unique tactic. There are several tastes: the ''in-place'' style supported by {{{destruct}}} and the ''push-on-goal'' style supported by {{{case}}}. The in-place style recommends to use {{{destruct}}}, {{{dependent destruction}}}, {{{inversion}}} and {{{case}}}, in this preference order (in particular {{{inversion}}} is not considered to be robust and predictable enough).

     * There is an overlapping between what {{{elim}}}, {{{induction}}} and {{{dependent induction}}} do and they should eventually merge into a unique tactic. In the meantime, the in-place style recommends to use {{{induction}}}, {{{dependent induction}}} and {{{elim}}} in this order.

     * Indent the different cases of an induction step at the same level. If most of the cases need several lines, separate cases by a blank line and use comments to make explicit which case it is.

   * Automation

     * {{{auto}}}/{{{eauto}}}: use the {{{using}}} clause as much as possible whenever it underlines the use of an important lemma for the proof.

     * Linear arithmetic: there is an overlapping between what {{{omega}}}, {{{romega}}} and {{{lia}}} do. In any cases, avoid {{{romega}}}; {{{lia}} is complete and generally faster but {{{omega}}} is better able to deal with non primitive symbols ({{{max}}}, {{{min}}}, natural numbers, ...).

   * In long proofs, use {{{now}}} as much as possible when a tactic closes the current goal. This improves the robustness of the script.

   * {{{double induction}}} is most often better replaced by {{{induction ...; destruct ...}}}

   * Prefer {{{revert}}} to {{{generalize}}}.

   * Chaining: chain successive applications of {{{apply}}}, {{{rewrite}}} as much as possible using the comma.

''To be continued''

== Documentation ==

New lemmas or definitions should be accompanied with a coqdoc-compliant header, even though most of the current library fails to follow this recommendation.

== Use of notations and unicode symbols ==

''Section to be expanded''
