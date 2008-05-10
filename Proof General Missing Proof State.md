A Proof General tip.

If you place the cursor after `Proof.` and type `C-c C-return`, you'll notice that the window displaying Coq's responses is (annoyingly) empty, instead of showing what is to be proved. The reason for this is that, actually, a different buffer is being displayed! (To see this, do `C-c C-n` and `C-c C-u` a few times and notice that the buffer name in the mode line changes.) You can use `C-c C-p` to switch the display back from the *response* buffer to the *goals* buffer.

Originally found [[http://www.cis.upenn.edu/~plclub/popl08-tutorial/code/coqdoc/CoqIntro.html|here]].
