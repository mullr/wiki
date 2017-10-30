This page attempts to summarize the long and informative discussion that happened when similar bugs were reported in Coq's and Agda's termination checker. The two threads can be found [here](https://sympa.inria.fr/sympa/arc/coq-club/2013-12/msg00119.html) and [here](https://sympa.inria.fr/sympa/arc/coq-club/2014-01/msg00036.html).

Summary of the discussion:
==========================

For the "types as propositions" paradigm to work, we need the types denoting non-trivial logical propositions to *not* have diverging elements. So, proof assistants based on the "propositions as types" idea need ways to ensure that certain types are total. The following properties are desirable of the methods that these proof assistants make available for writing such terminating functions/proofs <a name="criteria"></a>:

1.  Readability of code
2.  Logical simplicity. Compositionality is very important here
3.  Efficiency
4.  Minimality of annotations/proofs required from users.
5.  <a name="criteria5"></a>Equational behavior on open terms.

One might consider including expressivity in the list above, but it seems that for all the methods considered in this thread, a terminating function expressible by one method can be expressed by another method using a complicated-enough translation. One exception is noted [below](#classical).

People mainly considered the methods a)-d) below in this thread.

1.  [Recursors/Eliminators of inductive types](#recelim)
2.  [Guardedness predicate](#guarded)
3.  [Well-founded relations](#wfrel)
4.  [Sized Types](#sized)

These methods make different trade-offs between the properties 1)-5) [above](#criteria). We will discuss them one by one. We will end the discussion on each one with a list of pros and cons.  
**(Can some expert please add some comments on how these methods compare on the [property 5](#criteria5) ?)**

<a name="recelim">Recursors/Eliminators of inductive types</a>
--------------------------------------------------------------

In many proof assistants (e.g. HoTT, Nuprl) this is the fundamental way to use/eliminate an element of an inductive type. Functions defined using these recursors are guaranteed to be terminating. However, as Bruno mentioned in the [this](https://sympa.inria.fr/sympa/arc/coq-club/2013-12/msg00191.html) email, using recursors often does not produce readable code. He gives an example of a function (div2) function that can be concisely written using pattern matching, but becomes ugly when written using recursors. The following link shows both his concise and ugly versions in Coq. <http://www.cs.cornell.edu/~aa755/div2.html> (replace .html by .v to get the raw Coq code)

Another suggestion was to automatically translate functions written in the "beautiful" pattern matching syntax down to recursors. Cody mentioned that [Giménez1995](#Giménez1995) details the translation of a simple guard condition for Coq into recursors. (Cristina Cornes' [PhD thesis](https://who.rocq.inria.fr/Frederic.Blanqui/divers/cornes97phd-toc.pdf) also deals with this translation; probably, there are no known translations of this to English.) However, as Matthieu pointed out, this translation might incur a run-time overhead. Also, as Cody mentioned, it is unnatural for users to write some function and have to prove properties about some other function (obtained after translation). Ideally, the user should never have to see the translated version.

Pros : logical simplicity  
Cons: code readability, efficiency?

<a name="guarded">Guardedness predicate</a>
-------------------------------------------

This is the method currently used in Coq. Aside from being suspected as the root cause of at least two bugs discovered in Coq, this method is not compositional. To do guardedness checking, Coq has to unfold all the definitions used in the body of the function, do reductions, e.t.c. This makes typechecking extremely slow at times. Also, the unfoldings can cause the code to bloat by orders of magnitude and become impossible to debug. More importantly, minor syntactic changes to some definitions used in the body (while preserving semantics) can cause the type-checker to reject a legitimate function. See an example in the subsection 1.2.1 in [Sacchini2011](#Sacchini2011). 

The same subsection also explains why this guardedness predicate is also involved in the loss of SN (strong normalization). Here is the example:

````
Fixpoint F (n : nat) : nat := (fun _=> O)(F n).
````

The problem is that, if necessary, Coq reduces (computes) in bodies of fixpoints before checking termination but then stores the original body (not what was actually checked) in the kernel. The original body may fail the termination check.
If Coq stored in the kernel what was actually checked, Coq [may]((https://sympa.inria.fr/sympa/arc/coq-club/2017-01/msg00013.html)) be strongly normalizing.

Pros: code readability, efficiency?  
Cons: logical simplicity (lack of compositionality), code readability while debugging.

<a name="wfrel">Well-founded relations</a>
------------------------------------------

Coq also provides a way to write an arbitrary recursive function as long as one can provide a well-founded relation and prove that all recursive calls are performed on arguments that are "less" according to the well-founded relation. The *Function* construct implements this method. For a description of how to use it, see the 4^th variant in <http://coq.inria.fr/refman/Reference-Manual004.html#sec75> . A theoretical description of this construct is described in [Barthe2006](#Barthe2006) (it was called [GenFixpoint](GenFixpoint) at that time). It uses the so-called Bertot-Balaa method also named "converging iteration" which is described in [Balaa2000](#Balaa2000).

Again a problem is that the function that actually goes to Coq's kernel is much more complicated than what we write. However, Coq automatically generates and proves a lemma that expresses the 1-step unrolling of original recursive call (this section ends with an example). Another downside is that a lot of work might be required from the users. A user has to figure out a well-founded relation and prove that the recursive calls are made on "lesser" elements according to this relation. For some, this might not be a big problem. We can build powerful hint databases and tactics to automate much of these proofs.

The extracted code looks pretty much like the original code that the user writes down. The proofs are thrown away presumably because they are in *Prop*. So one can use <a name="classical">classical</a> axioms in the proofs and still have the Ocaml extract run w/o getting stuck. In this sense, this method might be more expressive than others. The following link that shows the kernel code, the extracted code, and the 1-step unfold equation for the *div2* function above and the *gcd* function expressed using the *Function* construct. <http://www.cs.cornell.edu/~aa755/div2.html#div2_Fun>

Pros: logical simplicity, efficient extracts, readability of extracts and user-written-code  
Cons: readability of the function that goes into kernel (users might have to deal with this version in proofs), may need more work from the users

<a name="sized">Sized Types</a>
-------------------------------

A presentation on this method can be found \[\[|here\]\]. The key idea is to consider approximations of an inductive type. A strictly positive inductive type can be obtained by iterating the corresponding endofunction (in some universe) over some ordinal. For an inductive type *T*, *T^s* denotes the members that can be (cumulatively) obtained by iterating until the ordinal (size) *s*. To typecheck a recursive function on the type *T*, it suffices that the recursive calls are made only on members of an approximation of *T* that corresponds to a lesser ordinal. This approach works uniformly even for [CoInductive](CoInductive) types and co-recursive functions (see [Sacchini2013](#Sacchini2013)). Basically, the "less than or equal to" relation on stages can be lifted to types as a subtype relation. While the *Inductive* types are covariant, the [CoInductive](CoInductive) types are contra-variant w.r.t. the sizes.

Despite the use of ordinals in the semantics, there are no ordinals in the syntax. There is only a successor and an infinity operator in the size-language. Moreover, the end user does not have to bother even with these sizes terms. The typechecker introduces size variables and maintains constraints among them. This is probably analogous to the way Coq currently maintains automatically maintains level variables and constraints for each use of *Type*. A user just indicates the decreasing argument of a *Fixpoint*. If the type of that argument is same as the return type, the return type can be tagged to indicate that the function is size-preserving (e.g. map). Note that size preserving just means that the output is of less or equal size.

In [Sacchini2011](#Sacchini2011), there is no way to express more precise size-specifications like the fact that the size of append's output is the sum of the sizes of its inputs. (see the discussion after definition 2.1 in [Sacchini2011](#Sacchini2011)) One could opt for a more expressive syntax for sizes (e.g. include operators for addition, maximum), but that might break the completeness of size inference and one of the design goals is to not let users mess with size expressions. As a result, not all the legitimate functions that satisfy the current (unsound) guardedness checker will satisfy the new sized type based typechecker. For example, the system in [Sacchini2011](#Sacchini2011) would probably not accept NPeano.gcd: <http://coq.inria.fr/stdlib/Coq.Numbers.Natural.Peano.NPeano.html#gcd> It can probably infer that *mod* is size preserving but that is not enough. Note that it not allowed to look inside the definition of mod, unlike the guardedness based typechecker.

Pros: logically simple (compositional), minimal work from users when it works  
Cons: users might still have to often use other mechanisms like [Well founded relations](#wfrel) on top of this

Pierre Courtieu [mentioned](https://sympa.inria.fr/sympa/arc/coq-club/2014-03/msg00086.html) that *Function* mechanism described [above](#wfrel) is just a wrapper around *Fixpoint* and it should work when sized types are used for *Fixpoint*

References
----------

<a name="Sacchini2011">Sacchini2011</a> :  Jorge Luis Sacchini. On Type-Based Termination and Dependent Pattern Matching in the Calculus of Inductive Constructions. PhD thesis, Ecole Nationale Supérieure des Mines de Paris, 2011. [PDF](http://pastel.archives-ouvertes.fr/docs/00/62/24/29/PDF/21076_SACCHINI_2011_archivage.pdf)

<a name="Sacchini2013">Sacchini2013</a> : Jorge Luis Sacchini. Type-Based Productivity of Stream Definitions in the Calculus of Constructions. In LICS, pages 233–242. IEEE Computer Society, 2013. [PDF](http://www.qatar.cmu.edu/~sacchini/papers/lics13.pdf)

<a name="Giménez1995">Giménez1995</a> :  Eduarde Giménez. Codifying guarded definitions with recursive schemes. LNCS, 1995. <http://link.springer.com/chapter/10.1007%2F3-540-60579-7_3>

<a name="Barthe2006">Barthe2006</a> : Gilles Barthe, Julien Forest, David Pichardie, and Vlad Rusu.
Defining and Reasoning About Recursive Functions: A Practical Tool for
the Coq Proof Assistant. In Proc of 8th International Symposium on
Functional and Logic Programming (FLOPS'06), volume 3945 of Lecture
Notes in Computer Science, pages 114-129, 2006. Springer-Verlag.

<a name="Balaa2000">Balaa2000</a> :  A. Balaa and Y. Bertot. Fix-point equations for well-founded
recursion in type theory. In M. Aagaard and J. Harrison, editors, Proceedings of TPHOLs'00, volume
1689 of Lecture Notes in Computer Science, pages 1-16. Springer-Verlag, 2000.
