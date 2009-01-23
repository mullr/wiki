We propose a Coq module, named '''Z_interface''' that provides two constants (to begin with).

 *  `input_stream_Z : Stream Z`,
accessing this stream will read the extracted program's input, assuming this input is solely composed of decimal representations of numbers (one per line),

 * `output_stream_Z : (stream Z) -> unit`,
passing a stream to this function will provoke the output of decimal representations of all members in the stream to be printed by the
program.

To use this, you simply need to define a constant of type `unit` whose value is computed by
`output_stream_Z` in you Coq code, then you extract the code, and compile it.

Here is an example of use:

{{{
Require Import ZArith Streams Z_interface.
Open Scope Z_scope.

Definition final := output_stream_Z(Streams.map (fun x => x + 2) input_stream_Z).

Extraction "adds_two.ml" Zdiv_eucl Z_to_n_int final.
}}}

To use the extracted code, you simply need to compile the two generated ml files:
{{{
ocamlc adds_two.ml
ocamlc -o adds_two adds_two.mli
./adds_two < ex.txt > ex1.txt
}}}
Assuming the file `ex.txt` contains the strings "1" "2" ..."5", each on a line,
the result file `ex1.txt` will contain the strings "3" "4" ... "7".
