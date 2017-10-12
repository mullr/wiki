{{{\#!coq  
Tactic Notation "subst" "++" :=  
repeat (  
match goal with | x : \_ |- \_ =&gt; subst x end);

cbv zeta beta in \*.

}}}

The tactic subst++ has a few benefits over &lt;code&gt;subst&lt;/code&gt;:

-   It never fails. (In contrast, subst fails when recursive equations are present.)
-   It substitutes all locally defined variables for their definitions. (subst does not do this automatically. Of course, this might be an undesired effect in some cases, e.g., it will erase the markers added by the \[\[Case (tactic)|Case\]\] tactic.)
-   It performs reductions that may have been enabled by the substitution of locally defined variables.

