#languae en

== Using latex to generate math ==

We use the latex2.py written by [http://johannes.sipsolutions.de/Projects/new-moinmoin-latex Johannes Berg].

You can type 

{{{
{ { { #!latex2
''some latex code without \begin{document} and \end{document}'' 
} } }
}}}

to get the generated dvi file inlined in your text. 

For example 

{{{!#latex2
$\forall m,n:N,\; \neg \frac{a}{b}=2^{\sup m,n}$
}}}

The most general form is

{{{
{ { { #!latex2
''latex preamble without \documentclass{article}''
 %%end-prologue%%
''latex body without \begin{document} and \end{document}'' 
} } }
}}}
