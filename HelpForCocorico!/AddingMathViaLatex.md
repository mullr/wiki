#languae en

== Using latex to generate math ==

We use the latex2.py written by [http://johannes.sipsolutions.de/Projects/new-moinmoin-latex Johannes Berg].

You can type 

{{{
{ { { #!latex2
"latex preamble"
 %%end-prologue%%
"latex body without \begin{document} and \end{document}" 
} } }
}}}

to get the generated dvi file inlined in your text. 
