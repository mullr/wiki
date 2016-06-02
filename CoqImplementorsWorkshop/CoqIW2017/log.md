This log page is empty.  Feel guilty and fill it!

== 02/06/2016 ==

 * Emilio:
   * Improve PR#185, fix some spacing inconsistencies between color and regular printer.
   * Verified that mirror-core and HoTT can be added to coq-contribs. They have a few problems with trunk thou.
   * Updated PR#145 to trunk, new PR#186
   * Add preliminary META file to Coq.

== 01/06/2016 ==

 * Emilio:
   * Tested performance with -flambda, no difference found with default options between 4.03.0 and 4.03.1+flambda. I couldn't get make to work with -O3 -unbox
   * Misc work on patches and many discussions with people.
   * Finish PR#180/181 in a satisfactory way.
   * https://github.com/coq/coq/pull/185 Remove unused confusing print tagging functions. This is a first step of a larger cleanup.

== 31/05/2016 ==

 * Emilio:
   * https://github.com/coq/coq/pull/180 Xml cleanup
   * https://github.com/coq/coq/pull/181 Factor out serialization code.
   * https://github.com/coq/coq/pull/184 Nits
   * Adapted math-comp and PIDECoq to trunk. https://bitbucket.org/ejgallego/pidetop/src/?at=coq-8.6 https://github.com/math-comp/math-comp/pull/48

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
