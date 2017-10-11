Coq 8.7 has a few incompatibilities with 8.6. We list the main sources of changes

== Changes in Coq file ==

> -   Change in the representation of constants in library ''Reals''
>     -   Typical consequences: {{{4}}} is not any more {{{2\*2}}}, {{{3}}} is not any more {{{2+1}}}, {{{-1}}} is now different from {{{-(1)}}}
>     -   expressions of the form {{{(-x)%R}}} hide a non-simplifiable coercion {{{IZR}}}; they do not simplify anymore; instead {{{unfold IZR; rewrite &lt;- INR\_IPR}}}
>     -   {{{auto with real}}} now solve all inequations between constants (e.g. {{{5&lt;=7}}})
> -   Fix of {{{rewrite ... in \*}}}

== Changes in plugin ==

There are may changes documented in {{{dev/doc/changes.txt}}}. The one empirically requiring the most updating are the following:

> -   New level of abstraction {{{EConstr}}}, documented in {{{dev/doc/econstr.md}}}. Typical changes to do in plugins:
>     -   replacing {{{open Term}}} with {{{open EConstr}}}
>     -   add a {{{sigma}}} to various functions now expecting it, e.g {{{dependent}}} (for old-style goals, get a {{{sigma}}} with {{{Tacmach.project}}})
>     -   replacing {{{kind\_of\_term}}} with {{{kind sigma}}}
>     -   replacing {{{Constr.equal}}} with {{{EConstr.eq\_constr sigma}}}
>     -   change {{{pr\_lconstr}}} into {{{pr\_leconstr}}}
>     -   change {{{fold\_constr}}} with {{{for\_constr sigma}}}
> -   Few changes in the representation of constr\_expr and related
>     -   {{{CLetIn}}} has now an explicit argument for the optional type
>     -   {{{LocalRawAssum}}} and {{{LocalRawDef}}} are now {{{CLocalAssum}}} and {{{CLocalDef}}}

