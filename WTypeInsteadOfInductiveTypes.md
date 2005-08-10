#language en

= W-Type =

W-type or well-ordered set constructor is introduced in ["Martin-LöfTypeTheory"] to construct well-ordered set. It can be used to construct many (all predicative?) inductive types of Coq.  

== W-type vs. Inductive types ==

However there some problems with using W-type constructor instead of inductive types of Coq:

 1. The elimination rule for inductive types couldn't be proved using intensional equality. For example if you define natural numbers using W-type then you will need extensional equality to obtain nat_elim. This is because one can not prove that there is only a unique function from empty set to the set of natural numbers without using extensionality.

 1. Using W-type it is difficult to encode complicated inductive types (e.g. mutual inductive families). You can use GeneralTreeConstructor to get over some of this difficulty, but still defining inductive types directly using their constructors (as it is done in Coq) is much easier in practice for programming. 

 1. You want to be able to define impredicative inductive types (at least in Prop). 

On the other hand basing a proof assistant on W-types has its own advantages:

 1. The system is simpler. You only have one constructor for all inductive types instead of adding inductive types one by one.  
