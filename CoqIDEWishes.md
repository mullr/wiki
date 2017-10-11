Wish list for COQIDE
====================

The purpose of this page is to list wishes for CoqIDE and to set priorities.

See also the `general wish list for graphical user interfaces`_.

Friendly first use of CoqIDE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Use default bindings compatible with most major platforms (e.g. Forward and Backward default key bindings Ctrl-Alt-Up/Down are unavailable under Gnome).

* F4/F5 query features better delimiting ident (taking qualified names, ' and _ under consideration).

* F4/F5 query features not forcing a selection in the clipboard.

* More user-friendly completion (without needing to type a neutral key to keep the completion or use a shortcut to complete).

* :strike:`Uniform behavior of copy-pasting between windows` Done in trunk.

* Replacing the not-often-used output windows by something using less work space?

Look and Feel
~~~~~~~~~~~~~

* Have a fully customizable colors set (in the 8.4 version I had to modify by hand "ide/tags.ml" to have my own set of colors).

    At the time this is written, you can modify "coqide-gtk2rc" in your xdg directory, but that only changes the background of the window, not the "light green" background of the already read part. This make this unusable for "dark themes" since in those themes, the background is dark whereas the foreground is light; as a result, you will end up with "light foreground" on "light green background" and it is barely readable. I guess a patch to read a configuration file for colors (maybe merge it with coqiderc; or better would be to use the coqide-gtk2rc file, but I am not a gtk pro, so I don't know how to do it) at startup should be easy to do; having a tab in the preference window would be even better, but longer to do.

Miscellaneous features
~~~~~~~~~~~~~~~~~~~~~~

* :strike:`Easier support for Unicode (support for some input method, e.g. writing \forall automatically display ∀)`. (Granted by V. Gross)

  * Linux/BSD/MacOS users : use a real input method such as http://code.google.com/p/uim/. Translation files should be pushed upstream soon.

  * Windows users : we haven't worked out a solution yet (I mean one that will not horribly backfire).

* :strike:`Proofs scripts folding` Done by V. Gross in trunk, feedback welcome.

* Ltac debugging à la coquille (https://code.google.com/p/coquille/)

* Print the current number a goals somewhere which is not subject to scrolling (number of goals should be always visible)

* Displays hypotheses and goal in two separate panes?

* Search/replace could be a pane at the bottom as in firefox (not a window)

* Search/replace could have the same semantics/shortcuts as in emacs

* A graphical advanced search windows for driving SearchAbout_.

* --A small detail: when after scrolling down in a fresh coqide we click inside the buffer, it brings back the pointer to the top instead putting it at the current location-- now ok

* --Allow editing buffer (only the white part) during evaluation-- provided by E. Tassi

* --Allow modifying comments (even in the green part) without re-evaluating the buffer-- partly provided by E. Tassi

* --Allow changing the target of evaluation (the scope of the blue part) during evaluation-- now ok

See also http://coq.inria.fr/bugs/show_bug.cgi?id=2144

Historical notes
~~~~~~~~~~~~~~~~

In 2009, the Coq development team had been given the opportunity to hire Vincent Gross for improving and extending CoqIDE. He moved it from a GTK-thread-based interface to a process-based interface, thus solving the following robustness and efficiency problems:

* When Coq started into a loop or long computation, there were no way to interrupt the Coq thread.

* When Coq raised a Stack Overflow, this often resulted in killing the whole CoqIDE process, even when CoqIDE was compiled with ocaml ≥ 3.10.

* Letting CoqIDE get the control between each Coq command was significantly slowing the buffer evaluation process.

* GTK threads in CoqIDE were unstable on Windows, sometimes resulting in segmentation fault errors.

Vincent Gross also fulfilled the following requests:

* :strike:`Easier support for Unicode (support for some input method, e.g. writing \forall automatically display ∀)`.

  * Linux/BSD/MacOS users: use a real input method such as http://code.google.com/p/uim/. Translation files should be pushed upstream soon.

  * Windows users : we haven't worked out a solution yet (I mean one that will not horribly backfire).

* :strike:`Proofs scripts folding` Done in trunk, feedback welcome.

.. ############################################################################

.. _general wish list for graphical user interfaces: ../GUIWishes

.. _SearchAbout: ../SearchAbout

