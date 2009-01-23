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

Here is the module.  Place this text in the file `Z_interface.v`.  In the long term, we expect this to become a library provided, for instance
in the Coq user-contribution.
{{{
Require Export ZArith Streams List String.

Axiom input_stream_Z : Stream Z.

Extract Constant input_stream_Z => "let z_of_string s =
  let rec digit_to_pos x = 
    if x = 1 then XH
    else if x mod 2 = 1 then XI (digit_to_pos (x / 2))
    else XO (digit_to_pos (x / 2)) in
  let digit_to_z x =
    if x = 0 then Z0 else Zpos (digit_to_pos x) in
  let sign = if String.get s 0 = '-' then Zneg XH else Zpos XH in
  let v = ref Z0 in
  (String.iter 
    (fun c ->
       if Char.code c <= Char.code '9' && Char.code '0' <= Char.code c then
          v := 
          zplus (zmult (Zpos (XO (XI (XO XH)))) !v)
              (digit_to_z (Char.code c - Char.code '0'))
       else if c = '-' && (!v = Z0) then ()
       else  failwith (""unexpected character in a number : "" ^ (String.make 1 c)
                       ^ ""\n"")) s; zmult sign !v) in
  let rec read_z_stream () =
    lazy (Cons (z_of_string (read_line()), (read_z_stream ()))) in
    read_z_stream ()".

Parameter n_int : Set.
Extract Constant n_int => "int".
Axiom nt2 : n_int -> n_int.
Extract Constant nt2 => "fun n -> 2 * n".
Axiom nt2p1 : n_int -> n_int.
Extract Constant nt2p1 => "fun n -> 2 * n + 1".
Axiom n0 : n_int.
Extract Constant n0 => "0".
Axiom n1 : n_int.
Extract Constant n1 => "1".
Axiom nopp : n_int -> n_int.
Extract Constant nopp => "fun x -> -x".

Fixpoint pos_to_n_int (x : positive) : n_int :=
  match x with
    xH => n1
  | xO p => nt2 (pos_to_n_int p)
  | xI p => nt2p1 (pos_to_n_int p)
  end.

Definition Z_to_n_int (x : Z) : n_int :=
  match x with
    Z0 => n0
  | Zneg p => nopp(pos_to_n_int p)
  | Zpos p => pos_to_n_int p
  end.

Axiom output_stream_Z :  (Stream Z) -> unit.
Extract Constant output_stream_Z =>
  "let fsign x = match x with Zneg _ -> true | _ -> false in
   (* this definition of zabs is needed, probably because zabs is inlined *)
   let zabs x = match x with Zneg p -> Zpos p | a -> a in
   let rec digits x =
     match x with
       Z0 -> []
     | _ -> let Pair (q,r) = zdiv_eucl x (Zpos (XO (XI (XO XH)))) in
          z_to_n_int r::digits q in
   let rec print_digit_list l sign =
          match l with
            [] -> if sign then print_string ""-""
          | a::tl -> print_digit_list tl sign; print_int a in
     let print_z a =
       let l = digits (zabs a) in
       (if l = [] then print_string ""0"" else print_digit_list l (fsign a);
        print_string ""\n""; flush stdout)  in
     let rec f s =
       let Cons(a, s') = try Lazy.force s with End_of_file -> exit 0 in
         (print_z a; f s') in
     f".
}}}

This starting contribution could be improved in several ways.  First, efficiency was not a design issue.  Second, new datatypes
could be covered.  In particular, the input could be read as a stream of strings (thus to be processed in a co-inductive way)
or as a single string (thus to be processed co-inductively).
