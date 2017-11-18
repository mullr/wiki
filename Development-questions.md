## How to traverse the environment?

The sequence of all declarations (logical ones such as `Definition`, but also non logical ones such as say `Notation`) is registered in a tree-like structure called the [`lib_stk`](https://github.com/coq/coq/blob/master/library/lib.ml#L99-L109). Each entry has a tag describing what kind of declaration it is, e.g. `"CONSTANT"` for `Theorem`/`Definition`/`Axiom`/`Parameter`/..., `"VARIABLE"` for `Variable`/`Hypothesis`/`Let`, `"INDUCTIVE"` for `Inductive`/`CoInductive`/`Record`/`Variant`, `"NOTATION"` for interpretation of notations, etc.

Independently, each kind of declaration generally comes with its own data structures or tables storing relevant information about this entry.

Back to the _library stack_, each entry there has a kernel name which is an identifier for fetching the information related to this entry in the appropriate table. For instance, with the kernel name of a `"CONSTANT"` you can get its body, type and other related informations by looking up the table of constants (function
[`Global.lookup_constant`](https://github.com/coq/coq/blob/master/library/global.mli#L81)). You can see examples of walking through the environment in the code for "Search" ([`Search.iter_declarations`](https://github.com/coq/coq/blob/master/vernac/search.ml#L69-L99) which itself relies on an iterator over module contents called
[`Declaremods.iter_all_segments`](https://github.com/coq/coq/blob/master/library/declaremods.mli#L107-L113)), or in the code for `Print All` ([`Printer.print_full_pure_context`](https://github.com/coq/coq/blob/master/printing/prettyp.ml#L724-L764)).
