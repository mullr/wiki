When converting some code from Coq to another target language (e.g. OCaml, Haskell, ...), the extraction mechanism does its best to preserve the names occurring in this code. This eases any interaction with the extracted code (call to extracted functions, review of their types, etc). But this isn't always possible. For instance:

 * The syntactic conventions may differ, for instance OCaml requires a inductive constructor to be capitalized, while Coq has no such constraint.

 * A Coq name could clash with a reserved keyword of the target language (e.g. "val" in OCaml).

 * A name x may refer in Coq to different things thanks to module qualification (A.B.x versus C.x), while the target language may lack such feature, or provide only part of it. For instance there's no inner modules in Haskell. And even OCaml is slightly more restrictive than Coq when it comes to fully qualified names (see below).

As a consequence, the extraction might need to perform a '''renaming'''. And this turns out to be quite tedious.

 1. The historical approach was simply to (un)capitalize as needed, and in case of clash with a keyword or previous name, to insert or increase a numeral postfix at the end of the name, e.g. {{{f}}} to {{{f0}}}, or {{{f1}}} if {{{f0}}} is already used, etc. This approach is still used in the so-called "monolithic" extraction ('''Recursive Extraction''' or '''Extraction "file"''') when no inner modules or functors are involved. In this case, the extracted code is a simple sequence of definitions, whose names haven't already be used before.

  * Pros: the generated names are close to their Coq counterparts and almost of the same length.

  * Cons: we cannot easily predict whether some name {{{f}}} will become {{{f}}}, {{{f0}}} or {{{f27}}}, since this depends on the "context" of {{{f}}} after extraction, e.g. the amount of other {{{f}}} constants in other libraries that will be incorporated in the extracted code. In particular, this method cannot be used for extracting modules with signatures : there would be no guarantee that a name is translated similarly in the implementation and in the signature. 

 2. Another renaming mode tries to produce predictable names. This mode is used for inner modules or functors, and when using the '''Extraction Library''' command (predictable names help when the extracted code is meant to be some library used by some other code).  When creating an uncapitalized name, we insert the prefix {{{coq__}}} before the original name when this name is capitalized, or is a keyword, or already starts with a {{{coq__}}} prefix. The same is done for obtaining capitalized name, with the prefix {{{Coq__}}}.  This renaming schema cannot lead to name clashes since it is bijective : from an obtained uncapitalized name we could retrieve the initial one by removing the 5 first characters if they are {{{coq__}}} or doing nothing otherwise. Note that the prefixes we use aren't reserved : the user can start her Coq names with them, it's just a bad idea since extracted names will then be ugly. Also note that the prefixes we use aren't magical : we just tried to pick ones that would be rare in Coq developments while not being too long nor cryptic. 

 3. Haskell and qualified names

 4. Painful situations

  * co-induction in OCaml

  * records with anonymous fields (OCaml)

  * modules and inaccessible qualified names (OCaml)

  * module parameters (OCaml)

  * names with unicode characters (TODO : is that true also in Haskell ?)
