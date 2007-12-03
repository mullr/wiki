#language en

This page is for discussing Cocorico's contents and structure.

== General style ==

=== English sentences vs internal WikiName to refer to internal pages ===

Cocorico uses the actual WikiName of an internal page to talk about it. I think that we would get more fluent texts if one'd use ordinary English sentences to mention an internal link. Compare for instance a mention to the [:CocoricoFrontPage:Cocorico's front page] and another mention to the same CocoricoFrontPage. [HH]

=== English sentences vs internal WikiName in titles ===

An [http://labix.org/snippets/moin-title extension] to MoinMoin allows to use ordinary English sentences for page titles. I believe it would offer the possiblity of more flexible and smoother-to-read page titles. [HH]

 The above patch is applied. -- MiladNiqui [[DateTime(2007-10-26T09:20:45Z)]]

An alternative solution is to directly use English sentences between quotes for wiki page names. This works well for new pages. For already existing pages in the !WikiName format, it would however require the renaming of all existing links to a so-renamed page. [HH]

=== External links ===

Should the exact URL of external links be made explicit in Cocorico pages (as it is the case for instance in the Tools page)? General web practice is to bind URL to regular English expressions rather than binding it the text of the URL. If one really wants to know an URL, it generally appears anyway at the bottom of the browser when the mouse is over the link. [HH]

=== Use of table of contents ===

My feeling is that table of contents are relevant on pages with proper elaborated contents. I don't think that they are necessary for pages that consists in a list of links. For instance, removing the table of contents from the [:CocoricoFrontPage:Cocorico's front page] would remove what at the end is just a redundant information. [HH]

 Yes, on the front page it was redundant (removed now). -- MiladNiqui

=== Reference to individuals ===

If one looks at the pages of [:WantedPages:wanted pages], one sees several pages named after a individual. Wouldn't it be better to link to the existing (external) page of the persons cited rather than creating new stub pages for these individuals? [HH]

  Yes it is a good idea. But the stub pages are also created for users of this wiki when they edit a page (because their username will appear on the RecentChanges page). In that case it might be good to put at least a link to the external page of the individual on the stub page.  -- MiladNiqui

== Organisation of the contents ==

My opinion is that Cocorico has now grown enough to justify a step of reorganisation of the contents. I don't have a clear global idea of what to do but a few restructuration steps are certainly worth to be done.

Among other things, I'm thinking about grouping similar topics under a same heading (grouping for instance the contact links ''nable'' and ''irc''; the documentation links [:Documentation:general documentation], the [:TheoryBehindCoq: logical theory] of Coq, extending the [:CoqCustomizationHowTo:source] of Coq and documentation on [:Modules:modules]).

I also wonder whether the front page could start with a short text, linking among others to the [:ComparisonWithOtherSystems:page] (from the CoqNewbie page) that compares Coq to other similar systems. [HH]

Here is a new proposition for formatting the Coq topic available on the [:CocoricoFrontPage:Front page].

||<tableclass="userpref">'''''The Coq Community'''''       ||<style="width: 25%">'''''Documentation'''''||<style="width: 25%">'''''Formalisations'''''||<style="width: 25%">'''''Software'''''  ||
||<style="width: 25%">[:CoqNewbie:The newbie zone]         ||[:Documentation:Books and Manuals]         ||[:StandardLibrary:Standard Library]         ||[:Tools:Interfaces]             ||
||[http://www.nabble.com/Coq-f2323.html Coq-club on Nabble]||[:Tutorials:Tutorials]                     ||[:FormalizedAndVerified:Formalized in Coq...]||[:Tools:Software Verification] ||
||[irc://irc.freenode.net/#coq irc channel]                ||[:FrequentlyAskedQuestions:Frequently asked questions] ||[:CoqPearls:Coq pearls]      ||[:Tools:Tactic plugins]             ||
||[:CoqInTheClassroom:Coq in the classroom]                ||[:TheoryBehindCoq:Logical foundations]                 ||[:LtacPearls:Tactic pearls]  ||[:Tools:Documentation tools]        ||
||                                                         ||[:SpecializedDocumentation:Misc. documentation]        ||[:ProjectIdeas:Project ideas]|| ||
||                                                         ||[:CoqSource:About Coq code source]                     ||[:CoqStyle:Coq's style]      || ||

Notes: ''About Coq source code'' would link to a new page that includes CoqCustomizationHowTo and TheSource; 
the page on [:ModuleSystem:modules] would be in the (new) [:SpecializedDocumentation:Misc. documentation] page; the UserContribution page would be integrated to the FormalizedAndVerified page. The TipsAndTricks page would be integrated to the FrequentlyAskedQuestions.

 Most of these are applied now. What should [:Tutorials:Tutorials]  point to? Right now it points to [:CoqNewbie:CoqNewbie]. -- MiladNiqui [[DateTime(2007-12-03T15:41:24Z)]]
