In facts before deciding between Records and Modules, consider the following:

 * Will you need to build a structure of this "type" "à la volée"
  * If so, a Record is probably better as you can't do inside terms a "let m := [module] in [expr]"
 * Do you want something very modular;
 for instance given three module types ''A'', ''B'' and ''C'', and two functors, ''f'': ''A'' -> ''B'' and ''g'': ''B'' -> ''C'',
 be able to define the functor ''h'': ''A'' -> ''C'', by ''h''=''g''o''f''?
  * If so, Records are more ... modular than ... modules...

 * Will your structure be extracted or do you want it extractable to caml/Haskell/...?
  * If so, I don't recommend use of Record (except maybe if you can express it directly with a record in the target language)
 * Will you need to define useful tactics inside your module?
  * If so you won't be able to define them inside Records, and lose the "dot" notation.
 * Will you need some toplevel instructions, such as "Implicit Arguments", "Print" and so...
  * Use Modules (Note that for Notations, you have a way to use "Reserved Notation" and "where" for Records)
 * Will you need some performances?
  * Use Modules, all is defined at toplevel and won't require function calls

In all other cases, Records are often a better solution.
