The Coq development team has been given the opportunity to improve and extended CoqIDE. The purpose of this page is to list wishes for CoqIDE and to set priorities.

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
 * More user-friendly completion (without needing to type a neutral key to keep the completion).
 * Uniform behavior of copy-pasting between windows.
 * Replacing the not-often-used output windows by something using less work space?

=== Miscellaneous features ===

 * Easier support for Unicode (support for some input-method, e.g. writing \forall automatically display ∀).
 * Proofs scripts folding (preliminary support already done in trunk version).
 * Proof-by-pointing features (Pcoq's spirit) using right-clic:
   * right-clicking on constants would propose "unfold",
   * moving equality statements in hypothesis to goal or other hypothesis with a left or right move would rewrite the given hypothesis,
   * selection of subterms by clicking on main symbol or by full selecting?
   * ability to mark hypotheses to which the next induction will apply
   * ...
 * Support for easy goal switching?
 * A graphical advanced search windows for driving SearchAbout.
 * Support for queries by right-clicking constants or selected expressions?
 * Key or right-click for making explicit hidden information (coercions, implicit arguments, notations, ...) on selected subterms.
 * Support for 2-dimension notations?

=== List of queries to support ===

 * Print Assumptions for a constant
 * Type of an expression
 * Locate a notation or a constant
 * ...

=== Views ===

 * Command to switch from .v view to a coqdoc view of the same buffer.
 * Command to switch to a view showing only Definition/Theorem names?
 * ...
