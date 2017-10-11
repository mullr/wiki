Hitchhiker's Guide to the Coq Source Tree
=========================================

A bit of notation :

-   terms and types are written with the form **symbol\_name:path/to/sourcefile.ml** or **(symbol\_name:type):path/to/sourcefile.ml** the first time they are encountered, and can be shortened to **symbol\_name** after.

TODO : refine notations conventions, to distinguish between terms and parameters and possibly include code as-is.

Adventures of a Vernac Command
------------------------------

There is two way to process strings coming from stdin. The first one is by looping over *do\_vernac:toplevel/toplevel.ml*, and the second one by looping over *parse\_one\_command\_group:toplevel/protectedtoplevel.ml*.

**do\_vernac** reads a vernac Command from stdin through **mt:lib/pp.ml4**, resynch the toplevel command buffer and feeds **(top\_buffer.tokens:char Stream.t):toplevel/toplevel.ml** to **raw\_do\_vernac:toplevel/vernac.ml**. **raw\_do\_vernac** is mainly a wrapper for **vernac:toplevel/vernac.ml**, which itself is a wrapper for **vernac\_com:toplevel/vernac.ml** that automatically feeds it with the output of **parse\_phrase:toplevel/vernac.ml**. **vernac\_com** does a pattern matching on the parsing result to handle file loading or command timing, and then calls **with\_heavy\_rollback:lib/states.ml** with **interp:toplevel/vernacentries.ml** as its first parameter. **interp** does the big match on the **vernac\_expr:toplevel/vernacexpr.ml** input and calls the appropriate function.

To be continued ...
