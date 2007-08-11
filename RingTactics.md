{{{#!coq
Require Export Ring.
}}}

== ringsimpl ==

The idea is to put all ring expressions occuring in the goal into normal form.  This tactic could use lots of improvement.

{{{#!coq
Ltac ringsimpl :=
match goal with
| |- (_ ?a ?b) => ring a b
| |- (?a ?b ?c) => try ringsimpl a; try ringsimpl b; try ringsimpl c
end.
}}}

== ringreplace ==

Instead of this tactic, you can now do {{{replace a with b by ring}}} in Coq.  Unfortuately this doesn't work for {{{setoid_replace}}}.See also wiki:Self:TacticExts#LHS for using replace with {{{LHS}}} and {{{RHS}}}.
 [http://scabby.o-f.com/71.html milf ass cum] | [http://erroneous.angelcities.com/41.html shemale dvd] | [http://gleans.150m.com/5.html 70s cartoon porn] | [http://atall.kogaryu.com/48.html squirt scream girls] | [http://guallatiri.1accesshost.com/25.html fuck pussy] | [http://genning.freewebsitehosting.com/50.html hotwife reality movies] | [http://unsurely.kogaryu.com/23.html celeb pussy slip] | [http://schonberg.angelcities.com/42.html webcam video girl] | [http://chlorides.741.com/97.html latina big movie] | [http://morns.100freemb.com/64.html bbw sexy lingerie] | [http://denser.ibnsites.com/53.html fem dom bitches] | [http://deskills.angelcities.com/80.html porn stars videos] | [http://inhibition.741.com/2.html young ejaculation squirting] | [http://trellis.00freehost.com/47.html indian girl cartoon] | [http://ombudsman.wtcsites.com/44.html anna malle mmf] | [http://troubles.freecities.com/84.html women pussy] | [http://congruity.o-f.com/85.html babes squirt] | [http://tawdriest.freewebsitehosting.com/53.html sexy hardcore fucking] | [http://inhibition.741.com/56.html molly model teenage] | [http://humphing.g0g.net/32.html cum bukkake handjob] | [http://parrot.100freemb.com/8.html shave pussy] | [http://schonberg.angelcities.com/5.html group blowjob party] | [http://spookiest.g0g.net/7.html deep anal milf] | [http://smocks.dreamstation.com/19.html anime strip tease] | [http://whiteys.kogaryu.com/39.html bum strip] | [http://childbirth.100freemb.com/62.html reality medical fetish] | [http://edginesses.1sweethost.com/20.html trannie blow] | [http://humanness.greatnow.com/64.html lesbian domination wa004] | [http://fervently.00freehost.com/45.html best facial cleansers] | [http://statically.9cy.com/85.html gaping anal insertion]
