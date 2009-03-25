= Hitchhiker's Guide to the Coq Source Tree =

A bit of notation :
 * terms and types are written with the form '''symbol_name:path/to/sourcefile.ml''' or '''(symbol_name:type):path/to/sourcefile.ml''' the first time they are encountered, and can be shortened to '''symbol_name''' after.

TODO : refine notations conventions, to distinguish between terms and parameters and possibly include code as-is.

== Adventures of a Vernac Command ==

There is two way to process strings coming from stdin. The first one is by looping over ''do_vernac:toplevel/toplevel.ml'', and the second one by looping over ''parse_one_command_group:toplevel/protectedtoplevel.ml''.

'''do_vernac''' reads a vernac Command from stdin through '''mt:lib/pp.ml4''', resynch the toplevel command buffer and feeds '''(top_buffer.tokens:char Stream.t):toplevel/toplevel.ml''' to '''raw_do_vernac:toplevel/vernac.ml'''. '''raw_do_vernac''' is mainly a wrapper for '''vernac:toplevel/vernac.ml''', which itself is a wrapper for '''vernac_com:toplevel/vernac.ml''' that automatically feeds it with the output of '''parse_phrase:toplevel/vernac.ml'''. '''vernac_com''' does a pattern matching on the parsing result to handle file loading or command timing, and then calls '''with_heavy_rollback:lib/states.ml''' with '''interp:toplevel/vernacentries.ml''' as its first parameter. '''interp''' does the big match on the '''vernac_expr:toplevel/vernacexpr.ml''' input and calls the appropriate function.

To be continued ...
