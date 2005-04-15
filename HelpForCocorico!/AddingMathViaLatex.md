#language en

== Using latex to generate math ==

We use the latex2.py Wiki parser written by [http://johannes.sipsolutions.de/Projects/new-moinmoin-latex Johannes Berg].

You can type 

{{{
{ { { #!latex2
''some latex code without \begin{document} and \end{document}'' 
} } }
}}}

to get the generated dvi file inlined (as a .png file) in your text. 

For example 

{{{#!latex2
$\forall m,n:{N}\;\; a,b:{Z},\; \neg \frac{a}{b}=2^{\sup (m,n)}$
}}}

You can also add a peramble containing user defined macros or \usepackage. For example we import the `amssymb` package to get the blackboard fonts for `N` and `Z`:

{{{#!latex2
\usepackage{amssymb}
 %%end-prologue%%
$\forall m,n:\mathbb{N}\;\; a,b:\mathbb{Z},\; \neg \frac{a}{b}=2^{\sup (m,n)}$
}}}

It is possible to include the outcome in between the text, as we do [[latex2(usepackage{amssymb}%$\neg\exists p,q\in\mathbb{Q}\;\; \frac{p}{q}=\sqrt{2}$)]] here!

The most general form is

{{{
{ { { #!latex2
''latex preamble without \documentclass{article}''
 %%end-prologue%%
''latex body without \begin{document} and \end{document}'' 
} } }
}}}
