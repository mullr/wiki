The Coq development team has been given the opportunity to improve and extend CoqIDE. The purpose of this page is to list wishes for CoqIDE and to set priorities.

(please complete or add comments or add stars "*" to vote for features)

=== Robustness and efficiency ===
CoqIDE uses GTK threads and launches Coq as a subthread. This raises the following problems:

 * If Coq starts into a loop or long computation, there is no way to interrupt the Coq thread.
 * If Coq raises a Stack Overflow, this often results in killing the whole CoqIDE process, even when CoqIDE is compiled with ocaml ≥ 3.10.
 * Ensuring CoqIDE gets the control between each Coq command significantly slows the buffer evaluation process.
 * Use of GTK threads in CoqIDE is not robust on Windows and it sometimes results in segmentation fault error.

The plan is to rebuild CoqIDE on a client-server basis, CoqIDE communicating with external coqtop processes, as ProofGeneral does. In particular, this requires to formalize a communication language for Coq and its interfaces.

=== Friendly first use of CoqIDE ===
 * Use default bindings compatible with most major platforms (e.g. Forward and Backward default key bindings Ctrl-Alt-Up/Down are unavailable under Gnome).
 * F4/F5 query features better delimiting ident (taking qualified names, ' and _ under consideration).
 * F4/F5 query features not forcing a selection in the clipboard.
 * More user-friendly completion (without needing to type a neutral key to keep the completion or use a shortcut to complete).
 * Uniform behavior of copy-pasting between windows.
 * Replacing the not-often-used output windows by something using less work space?

=== Miscellaneous features ===
 * Easier support for Unicode (support for some input method, e.g. writing \forall automatically display ∀).
 * Proofs scripts folding (preliminary support already done in trunk version).
 * Proof-by-pointing features (Pcoq's spirit) using right-clic:
  * right-clicking on constants would propose "unfold",
  * moving equality statements in hypothesis to goal or other hypothesis with a left or right move would rewrite the given hypothesis,
  * selection of subterms by clicking on main symbol or by full selecting?
  * ability to mark hypotheses to which the next induction will apply
  * ...
 * Support for easy goal switching?
 * Print the current number a goals somewhere which is not subject to scrolling (number of goals should be always visible)
 * Displays hypotheses and goal in two separate panes ?
 * Use tab to indent proofs
 * Search/replace could be a pane at the bottom as in firefox (not a window)
 * Search/replace could have the same semantics/shortcuts as in emacs
 * A graphical advanced search windows for driving SearchAbout.
 * Support for easy selection of structural features (definitions, terms, subterms, identifiers...)?
  * could be a separate view (see below)
  * pcoq can do this
  * Alfa (agda1) also does this: it's deeply integrated with its natural language support.
 * Support for queries by right-clicking constants or selected expressions? what about a tooltip (if you keep the pointer on a constant more than 3 seconds, it displays its type, definitions...)
 * Key or right-click for making explicit hidden information (coercions, implicit arguments, notations, ...) on selected subterms.
 * *Support for 2-dimension notations?
  * pcoq and alfa/agda1 have some support for this
 * Automatically expand unnamed intros into intros with explicit names
 * Automatically compile .v  if necessary when 'Require' are evaluated
 * A small detail: when after scrolling down in a fresh coqide we click inside the buffer, it brings back the pointer to the top instead putting it at the current location
 * Allow editing buffer (only the white part) during evaluation
 * Allow modifying comments (even in the green part) without re-evaluating the buffer
 * Allow changing the target of evaluation (the scope of the blue part) during evaluation
 * Allow partial evaluation of ; sequences as in Matita : for example evaluating only T1;T2 in the sequence T1;T2;T3 without writing T1;T2. T3.
  * could be a switchable option, useful for debugging complex proof scripts.
  * what about other tacticals?
 * Reflect the tree structure of the proof into a gtk tree widget to allow hiding parts of the proof.
  * is this the same as proof-scripts folding? (see above)
  * most procedural proof scripts don't have much of a tree structure. does this apply to proof-terms, declarative proofs or what?
 * Support for natural language explanations in proofs?
  * useful for beginners
  * coq 6.* and pcoq had this
  * alfa integrated this with support for 2D views
  * declarative proofs may make this unnecessary
   * but need some means of converting from proof terms (Matita does this) or procedural proof scripts
  * drawback: full natural-language proofs quickly become overwhelming
   * Alfa supports hybrid representation: use symbols for low-level manipulation, natlang for the higher-level structure

=== List of queries to support ===
 * Print Assumptions for a constant
 * Type of an expression
 * Locate a notation or a constant
 * ...

=== Views ===
 * Command to switch from .v view to a coqdoc view of the same buffer.
 * Command to switch to a view showing only Definition/Theorem names?
 * Display dependency trees and graphs for:
   * modules
   * theorems
   * library contributions
  * optionally use graphviz for graph rendering?
