Highlighted syntax for various languages
========================================

It is possible (using a parrser based on [Gnu enscript](http://www.codento.com/people/mtr/genscript/)) to produce colorized syntax for various programming languages.

You have to use the folloiwng format

    { { { #! syntax <language-name>
    <code>
    } } }

Of course your language-name shoud be among the [languages recognised by Gnu enscript](http://www.codento.com/people/mtr/genscript/highlightings.html).

For example,

    { { {#!syntax haskell

> type Vector = \[Double\]
>
> normSquared :: Vector -&gt; Double normSquared = sum . map (^2)
>
> norm :: Vector -&gt; Double norm = sqrt . normSquared } } }

generates the folloiwng `Haskell` code.



