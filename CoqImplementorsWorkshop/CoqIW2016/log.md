This log page is empty.  Feel guilty and fill it!

== 31/05/2016 ==

 * Emilio:
   * https://github.com/coq/coq/pull/180 Xml cleanup
   * https://github.com/coq/coq/pull/181 Factor out serialization code.
 

== 30/05/2016 ==

 * Extraction's corner cases do not occur in Compcert
 * Coq does not try to print "constant names" with the same qualification the user did input them.  The Nametab still picks the shortest, non ambiguous, qualification. 

 * Emilio:
   * Submitted PR#178: Backport of the new universe checking algorithm to V8.5
   * Moved coq-serapi to trunk. Note issues with serializing Genarg.
   * Review PR#143 with Enrico.
   * Submitted new version of PR#143 -> PR#179, seems ready.
   * Review problems of PR#178 with Matthieu, seems he has some idea.
 * Yves:
   * Work on plugins/romega/ReflOmegaCore.v, making it robust to number structures where the equality is just an equivalence relation compatible with the operations.
