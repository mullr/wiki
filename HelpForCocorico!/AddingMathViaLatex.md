Using latex to generate math
============================

We use the latex2.py Wiki parser written by [Johannes Berg](http://johannes.sipsolutions.de/Projects/new-moinmoin-latex).

You can type

    { { { #!latex
    ''some latex code without \begin{document} and \end{document}''
    } } }

to get the generated dvi file inlined (as a .png file) in your text.

For example

    latex error! exitcode was 2 (signal 0), transscript follows:

    failed to exec() latex

You can also add a peramble containing user defined macros or usepackage. For example we import the `amssymb` package to get the blackboard fonts for `N` and `Z`:

    latex error! exitcode was 2 (signal 0), transscript follows:

    failed to exec() latex

It is possible to include the outcome in between the text, as we do \[\[latex2(\\usepackage{amssymb}%$\\neg\\exists p,q\\in\\mathbb{Q},\\;\\; \\frac{p}{q}=\\sqrt{2}$ )\]\]\_ here!

The most general form is

    { { { #!latex
    ''latex preamble without \documentclass{article}''
     %%end-prologue%%
    ''latex body without \begin{document} and \end{document}''
    } } }
