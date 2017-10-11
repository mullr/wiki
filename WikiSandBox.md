## Please edit system and help pages ONLY in the moinmaster wiki! For more
## information, please see MoinMaster:MoinPagesEditorGroup.
## master-page:WikiSandBox

Please feel free to experiment here, after the four dashes below... and please do **NOT** create new pages without any meaningful content just to try it out!

**Tip:** Shift-click "HelpOnEditing_" to open a second window with the help pages.

-------------------------



::

   data S = Do | Re | Mi

::

   data Song = Do | Re | Mi

::

   \}\}\}

`[[RandomQuote]]`_ onsider a vector represented as a list of doubles.  Suppose we want to normalize a vector.  The standard method is to compute the length in one pass, and scale the vector in another pass

::

   type Vector = [Double]
   normSquared :: Vector -> Double
   normSquared = sum . map (^2)
   norm :: Vector -> Double
   norm = sqrt . normSquared
   scale :: Double -> Vector -> Vector
   scale a = map (a*)
   normalize :: Vector -> Vector
   normalize v = scale (recip (norm v)) v

It is possible to do ``scale`` and ``normSquared`` at the same time. Internally the data must still be processed twice but this can be hidden.

Consider a vector represented as a list of doubles.  Suppose we want to normalize a vector.  The standard method is to compute the length in one pass, and scale the vector in another pass:

::

   type Vector = [Double]
   normSquared :: Vector -> Double
   normSquared = sum . map (^2)
   norm :: Vector -> Double
   norm = sqrt . normSquared
   scale :: Double -> Vector -> Vector
   scale a = map (a*)
   normalize :: Vector -> Vector
   normalize v = scale (recip (norm v)) v

It is possible to do ``scale`` and ``normSquared`` at the same time. Internally the data must still be processed twice but this can be hidden.

::

   -- fst of the result is the scaled value of the vector
   -- snd of the result is the squared norm of the vector before scaling
   scaleAndNormSquared :: Double -> Vector -> (Vector, Double)
   scaleAndNormSquared a [] = ([], 0)
   scaleAndNormSquared a (x:xs) = (a*x:recScale, x*x+recNormSquared)
     where (recScale, recNormSquared) = scaleAndNormSquared a xs

Now using the laziness of Haskell, and recursive binding, we can use ``scaleAndNormSquared`` to create a virtually one-pass normalization. We need to scale by the reciprocal of the square-root of ``normSquared``.  So we say exactly that.

::

   circNormalize :: Vector -> Vector
   circNormalize v = scaledVector
     where (scaledVector, normSquared) = scaleAndNormSquared (recip (sqrt normSquared)) v

Now using the laziness of Haskell, and recursive binding, we can use ``scaleAndNormSquared`` to create a virtually one-pass normalization. We need to scale by the reciprocal of the square-root of ``normSquared``.  So we say exactly that.

::

   circNormalize :: Vector -> Vector
   circNormalize v = scaledVector
     where (scaledVector, normSquared) = scaleAndNormSquared (recip (sqrt normSquared)) v

.. raw:: html

Formatting
----------

*italic* **bold** ``typewriter``

``backtick typewriter`` (configurable)

:big:`bigger`  :small:`smaller` 

::

   preformatted some more
   and some more lines too

::


   def syntax(highlight):
       print "on"
       return None
::


     public void main(String[] args]){
        System.out.println("Hello world!");
     }
Linking
-------

HelpOnEditing_ InterWiki_

http://moinmoin.wikiwikiweb.de/ Python_

`someone@the.inter.net`_

An `internal link`_ that looks like normal text.

Image Link
~~~~~~~~~~

http://c2.com/sig/wiki.gif

Smileys
-------

|/!/| Alert

Lists
-----

Bullet
~~~~~~

* first

  1. nested and numbered

  #. numbered lists are renumbered

* second

* third blockquote

    deeper

Glossary
~~~~~~~~

Term  Definition

Drawing
~~~~~~~

`mytest.tdraw`_

Heading 1
=========

Heading 2
---------

Heading 3
~~~~~~~~~

Heading 4
:::::::::

IRC Log test
============

::


   (23:18) <     jroes> ah
   (23:19) <     jroes> hm, i like the way {{{ works, but i was hoping the lines would wrap
   (23:21) -!- gpciceri [~gpciceri@host181-130.pool8248.interbusiness.it] has quit [Read error: 110 (Connection timed out)]
   (23:36) < ThomasWal> you could also write a parser or processor
   (23:38) <     jroes> i could?
   (23:38) <     jroes> would that require modification on the moin end though?
   (23:38) <     jroes> i cant change the wiki myself :x
   (23:39) < ThomasWal> parsers and processors are plugable
   (23:39) < ThomasWal> so you dont need to change the core code
   (23:40) < ThomasWal> you need to copy it to the wiki data directory though
   (23:40) <     jroes> well, what i meant to say was that i dont have access to the box running the wiki
   (23:40) < ThomasWal> then this is no option
   (23:40) <     jroes> yeah :/
roonk_ `rezeptfrei kaufen`_ `Armee Russland`_ Sixpack_

.. ############################################################################

.. _HelpOnEditing:
.. _internal link: ../HelpOnEditing

.. _InterWiki: ../wiki:MoinMoin:InterWiki

.. _Python: http://www.python.org/

.. _someone@the.inter.net: mailto:someone@the.inter.net

.. _mytest.tdraw: drawing:mytest.tdraw

.. _roonk: http://www.roonk.de/

.. _rezeptfrei kaufen: http://www.rezeptfrei-kaufen.com/

.. _Armee Russland: http://armee.roonk.de/

.. _Sixpack: http://www.easysixpack.de/

