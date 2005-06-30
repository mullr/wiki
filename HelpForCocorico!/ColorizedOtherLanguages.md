#language en
= Highlighted syntax for various languages =

It is possible (using a parrser based on [http://people.ssh.com/mtr/genscript/ Gnu enscript]) to produce colorized syntax for various programming languages.

You have to use the folloiwng format

{{{
{ { { #! syntax <language-name>
<code>
} } }
}}}

Of course your language-name shoud be among the [http://people.ssh.com/mtr/genscript/highlightings.html languages recognised by Gnu enscript].

For example, 

{{{
 { { {#!syntax haskell
type Vector = [Double]

normSquared :: Vector -> Double
normSquared = sum . map (^2)

norm :: Vector -> Double
norm = sqrt . normSquared
 } } }
}}}


generates the folloiwng `Haskell` code. 

{{{#!syntax haskell
type Vector = [Double]

normSquared :: Vector -> Double
normSquared = sum . map (^2)

norm :: Vector -> Double
norm = sqrt . normSquared
}}}
