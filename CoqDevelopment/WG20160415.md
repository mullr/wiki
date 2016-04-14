## page was copied from CoqDevelopment/CoqWG20150915
## page was renamed from CoqDevelopment/NextCoqWG
## page was copied from CoqDevelopment/CRGTCoq20131126
## page was copied from CoqDevelopment/CRGTCoq20130709
<<TableOfContents>>

This page is used to organize the next Coq Working Group (in French GT Coq). The framadate link to decide which day it will happen is:

 . https://framadate.org/S8v3Q21TcZfqCRCx

= Organization =
The next Coq Working Group will take place on April 15th at Sophie Germain, PPS on the 3rd floor.

= Schedule =
 * 10:00 - 10:05 Introduction (Maxime)
 * 10:05 - 11:30 Roadmap and calendar for 8.6 (Matthieu)
 * 11:30 - 11:40 Break
 * 11:40 - 11:50 News from the EUtypes COST action (Assia)
 * 11:50 - 12:00 About ways to display goals and error messages in a more compact way (Pierre)

 * 12:00 - 13:30 Lunch

 * 13:30 - 13:50 Development practices (Matthieu)
 * 13:50 - 14:00 CEP(es) a way to propose features for Coq (Enrico)
 * 14:00 - 14:15 a document format for Coq 8.7 (Enrico)
 * 14:15 - 14:30 New vernac syntax "Numeral Notation" (Daniel)
 * 14:30 - 14:45 Break
 * 14:45 - 15:15 Improving setoid_rewrite (Paul)
 * 15:15 - 15:45 PR#143, PR#145 and API for IDEs (Emilio)

= Topics for discussion =
 * Roadmap and calendar for 8.6
 * Reviewing pull requests?

=== Pierre Courtieu proposes: ===
 * About ways to display goals and error messages in a more compact way (10mn max)

=== Emilio proposes: ===
If there's time and interest I could lead:

 * Review of PR#143: IMHO is mostly ready to go but there's a funny thing happening in trunk.

 * Commentary of PR#145: Not ready to merge yet, but I could explain what the problem is trying to solve, and what is the current (far from perfect) solution)

 * Evolution of the API for IDEs: I have some ideas towards evolving the current API for IDEs, this could be a good project to do for at the Hackcoqton, but I'd be great to have some feedback now.

=== Paul Steckler proposes: ===
 * improving code sharing between rewrite and setoid_rewrite
 * memoizing repeated operations in setoid_rewrite, maybe involving typeclass instantiation
 * mechanism for testing tactic timing benchmarks and notification of anomalies, via Jenkins or other tool; which tactics should be benchmarked

=== Assia proposes: ===
 * News from the [[http://www.cost.eu/COST_Actions/ca/CA15123?management|EUtypes]] COST action (10 min)

=== Daniel de Rauglaudre proposes: ===
 * New vernac syntax "Numeral Notation", allowing to use strings of digits in user numeral types. Implemented in Coq numeral types (nat, Z, R, etc.), their plugin OCaml versions being removed (15 min).

=== Matthieu Sozeau proposes: ===
 * Development practices - A short talk about the practices we want to advocate and a call for contributions (10min).

=== Enrico Tassi ===
 * [[https://coq.inria.fr/cocorico/CEP/CEP-0|CEP(es)]] a way to propose features for Coq (aka DEP in Debian, PEP in Python, tickets in Haskell, … RFC …) 10min
 * CEP-1 a document format for Coq 8.7, 10m
  
