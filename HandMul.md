Here is a fun way to do multiplications by hand.<<BR>> Each hand represents a number.<<BR>> To represent six, we close all the fingers except the big one {{attachment:six.png}} .<<BR>>  This is seven {{attachment:seven.png}} . <<BR>>  This is eight {{attachment:eight.png}} . <<BR>> Finally this is nine {{attachment:nine.png}}. <<BR>>

Now we are ready to do 7 * 9, the left hand takes 7 the right one 9 {{attachment:seven.png}} {{attachment:rnine.png}} . <<BR>> Now, the idea is simple, the sum of the fingers up gives the tens, and the product of the fingers down the units.<<BR>> On our example 7 * 9, how many fingers are up? 6 (2 on the left, 4 on the right). Now for the units, 3 fingers down for the left hand, one for the right, so 3 units (3 * 1). Putting tens and units together we get 63. Magic!

{{{#!coq
(* A magic way to do multiplication with hands *)

Inductive hand : Type := Hand6 | Hand7 | Hand8 | Hand9.

(* We can do any value from 6 to 9 with one hand. To do 8 we keep
   only three fingers up (so two fingers down) *)
Definition val_of h := 
match h with Hand6 => 6 | Hand7 => 7 | Hand8 => 8 | Hand9 => 9 end.

Coercion val_of : hand >-> nat.

(* Number of fingers up: to do 8 three fingers up *)
Definition up h := 
match h with Hand6 => 1 | Hand7 => 2 | Hand8 => 3 | Hand9 => 4 end.

(* Number of fingers up: to do 8 two fingers down *)
Definition down h := 
 match h with Hand6 => 4 | Hand7 => 3 | Hand8 => 2 | Hand9 => 1 end.

(* The left hand holds the first number, the right hand the second number,
   the production is composed 
     for the decimals by the sum of the fingers up and 
     for the units by the product of the fingers down
 *)
Theorem hand_mult: forall (left right: hand),
  left * right = (up left + up right) * 10 + (down left * down right).
Proof.
intros left right; destruct left; destruct right; trivial.
Qed.
}}}
