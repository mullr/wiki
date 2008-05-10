By default, Proof General displays error messages as black text on a red background. You can change this using with the following Emacs Lisp code.
{{{
 (add-hook 'proof-mode-hook
    '(lambda ()
       (set-face-background (quote proof-error-face) "white")))
}}}
Alternatively, within emacs, run
{{{
 M-x customize-face
}}}
When prompted for a face, specify proof-error-face. 
