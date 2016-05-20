When converting some code from Coq to another target language (e.g. OCaml, Haskell, ...), the extraction mechanism does its best to preserve the names occurring in the code. This eases any interaction with the extracted code (call to extracted functions, review of their types, etc). But this isn't always possible. For instance:

 * The syntactic conventions may differ, for instance OCaml and Haskell require a inductive constructor to be capitalized, while Coq has no such constraint.

 * A Coq name could clash with a reserved keyword of the target language (e.g. {{{val}}} in OCaml).

 * A name {{{x}}} may refer in Coq to different things thanks to module qualification ({{{A.B.x}}} versus {{{C.x}}}), while the target language may lack such feature, or provide only part of it. For instance there's no inner modules in Haskell. And even OCaml is slightly more restrictive than Coq when it comes to fully qualified names (see below).

As a consequence, the extraction might need to perform a '''renaming'''. And this turns out to be quite tedious.

 1. '''Monolithic renaming'''. The historical approach was simply to (un)capitalize as needed, and in case of clash with a keyword or previous name, to insert or increase a numeral postfix at the end of the name, e.g. {{{f}}} to {{{f0}}}, or {{{f1}}} if {{{f0}}} is already used, etc. This approach is still used in the so-called "monolithic" extraction ('''Recursive Extraction''' or '''Extraction "file"''') when no inner modules or functors are involved. In this case, the extracted code is a simple sequence of definitions, whose names haven't already been used before.

  * Pros: the generated names are close to their Coq counterparts and almost of the same length.

  * Cons: we cannot easily predict whether some name {{{f}}} will become {{{f}}}, {{{f0}}} or {{{f27}}}, since this depends on the "context" of {{{f}}} after extraction, e.g. the amount of other {{{f}}} constants in other libraries that will be incorporated in the extracted code. In particular, this method cannot be used for extracting modules with signatures : there would be no guarantee that a name is translated similarly in the implementation and in the signature. 

 2. '''Modular renaming'''. Another renaming mode tries to produce predictable names. This mode is used for inner modules or functors, and when using the '''Extraction Library''' command (predictable names help when the extracted code is meant to be some library used by some other code).  When creating an uncapitalized name, we insert the prefix {{{coq_}}} before the original name when this name is capitalized, or is a keyword, or already starts with a {{{coq_}}} prefix. The same is done for obtaining capitalized name, with the prefix {{{Coq_}}}.  This renaming schema cannot lead to name clashes since it is bijective : from an obtained uncapitalized name we could retrieve the initial one by removing the 4 first characters if they are {{{coq_}}} or doing nothing otherwise. Note that the prefixes we use aren't reserved : the user can start her Coq names with them, it's just a bad idea since extracted names will then be ugly. Also note that the prefixes we use aren't magical : we just tried to pick ones that would be rare in Coq developments while not being too long nor cryptic. 

 3. '''Haskell and qualified names'''. When extracting to Haskell, only the modules-as-v-files structure is kept. Applied functors are expanded (that's defunctorization). Inner modules are "flattened" : their content is placed at the toplevel of the current file. To avoid name clashes during these flattenings, the following renaming takes place : {{{A.B.c}}} become {{{A__B__c}}}, and we add an extra {{{_}}} prefix if the generated name is capitalized while it should not be. Note that unlike the previous renamings, this isn't clash-safe : the user could have used a Coq name {{{A__B__c}}}.

  * For the moment, a warning informs the user that the substring {{{__}}} is reserved for the extraction and shouldn't be use inside user names.

  * I don't see (yet?) a solution that would be a) predictable b) clash-free c) without reserved substring. For instance, adding a specific prefix in front of {{{A__B__c}}} might help, but that doesn't fully avoid names clashes: {{{A.B.c}}} and {{{A__B.c}}} would still be extracted to the same names. A possible compromise could be to transform the module path into a unique number (hash?), leading to names of the form {{{coq_123_c}}}. These names aren't predictable easily, but we might add comments relating these unique numbers and the corresponding module path ? 

 4. '''Other painful situations'''. For now, most of the solutions implemented to the issues below implies the use of the {{{__}}} substring in a non-clash-safe way, and hence a warning informs the user that this substring is reserved for the extraction.

 4.1. '''co-induction''' (OCaml). For a co-inductive type {{{foo}}}, we currently produce a mutual block in OCaml :
  {{{
type foo = __foo Lazy.t and __foo = FooConstr1 ... | FooConstr2 ...
  }}}
  In the rest of the code, it's {{{foo}}} that appears : {{{__foo}}} is only an internal intermediate step. But it may well interfere with a user-defined type of the same name.

  * Alternative solution that would be clash-safe : use another prefix, for instance here use the name {{{coqL__foo}}} (with L as in Lazy). 

 4.2. '''Anonymous fields''' in records (OCaml). In Coq, it is not mandatory to name all record fields.
  {{{
Record foo := { field : nat; _ : bool}.
  }}}
  Currently, the extraction generates a field name of the form {{{foo__123}}} for the 123-th field of record {{{foo}}} when this field is anonymous.

  * Alternative solution that would be clash-safe : use another prefix, for instance here use the name {{{coqF__foo__123}}} (with F as in field).

  * Note that Haskell isn't concerned for the moment, since records are treated as standard inductive types during this extraction.

 4.3. '''modules and inaccessible qualified names''' (OCaml). Even if the Coq and OCaml module systems are very similar, the first one is slightly more permissive when it comes to qualifying names.
  {{{
Module M.
 Definition t := 0.
 Module N.
  Definition t := 1.
  Definition u := M.t.
 End N.
End M.
  }}}
  In this example, the module {{{M}}} can be used to refer to objects even though {{{M}}} isn't finished yet. OCaml doesn't allow that for normal modules. And recursive modules have significant restrictions : an interface should be present after a {{{module rec M}}}, and the translation to OCaml of the previous example (with a {{{module rec M}}}) is rejected (Error : cannot safely evaluate the definition of the recursively-defined module M). We currently handle this situation via extra local modules, whose generated names are of the form {{{Coq__123}}}. Here:
  {{{
module M = struct
 module Coq__0 = struct
  let t = O
 end
 let t = Coq__0.t
 module N = struct
  let t = S O
  let u = Coq__0.t
 end
end
  }}}

  * Note : this is actually clash-safe : the part after the {{{Coq__}}} prefix is a number, and cannot interfere with identifiers coming from a modular rename (see section 2 above). And a user module of name {{{Coq__22}}} would have been converted to {{{Coq__Coq__22}}}.

  * Note : these local disambiguating modules are also used in the following situation, which is rather common:
  {{{
Module M.
 Definition t := nat.
 Module N.
  Definition t := t.
 End N.
End M. 
  }}}
  In OCaml, a {{{type t = t}}} would be wrong, since type definition is recursive by default, so we also use here a local naming submodule. '''TODO''': for OCaml >= 4.02, we could generate here {{{type nonrec t = t}}}.

 4.4. '''module parameters''' (OCaml). Inside a functor, its parameter name might be shadowed, but the content of the parameter might remain accessible.
  {{{
Module Type T. Parameter t : nat. End T.
Module F (X:T).
 Module X. Definition u := 0. End X.
 Definition v := X.t. (* This X is the parameter of F, not the inner submodule !! *)
End F.
  }}}
  To support this "peculiar" feature, the extraction renames here the functor parameter, using an internal unique id (see {{{MBId}}} in {{{names.ml}}}), leading to names such as {{{X__123}}}.

  * Alternative solution that would be type-safe : use another prefix, for instance here use the name {{{coqP__X__123}}} (with P as in parameter).

 4.5. '''unicode characters'''. OCaml doesn't accept unicode characters in names while Coq does.
  {{{
Definition αβγ := 123.
  }}}
  We currently convert each non-ascii characters to a substring of the form {{{__U1234_}}} where 1234 is the unicode index of the character.
  
  * I see no proper solution that would be a) predictable b) clash-safe c) without reserved substring such as {{{__}}}. In particular, how to generate different names for {{{aα}}} and {{{a__U03B1_}}} (with 03B1 being the unicode index of α) ? At least, we could consider here that the reserved substring is rather {{{__U}}}, which is probably much less frequent than {{{__}}}.

  * In Haskell, the most recent norm accept unicode letters in names, and apparently ghc supports it (but hugs does not). Anyway, before leaving unicode characters in Haskell extraction (probably via a user flag), we should first compare the range of unicode letters accepted by Coq and by Haskell.


A final note : {{{__}}} is also used by the extraction to name the constant which is substituted to eliminated code. With respect to renaming, this isn't a big deal: We simply consider this {{{__}}} name as a keyword of the target language, so any user-defined {{{__}}} is renamed into something else.

See also: [[https://github.com/coq/coq/pull/149|Pull Request 149]].
