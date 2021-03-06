This page is for discussing Cocorico's contents and structure.

General style
=============

English sentences vs internal WikiName to refer to internal pages
-----------------------------------------------------------------

Cocorico uses the actual [WikiName](WikiName) of an internal page to talk about it. I think that we would get more fluent texts if one'd use ordinary English sentences to mention an internal link. Compare for instance a mention to the [Cocorico's front page](CocoricoFrontPage) and another mention to the same CocoricoFrontPage. \[HH\]

English sentences vs internal WikiName in titles
------------------------------------------------

An [extension](http://labix.org/snippets/moin-title) to [MoinMoin](MoinMoin) allows to use ordinary English sentences for page titles. I believe it would offer the possiblity of more flexible and smoother-to-read page titles. \[HH\]

> The above patch is applied. -- [MiladNiqui](MiladNiqui) \[\[DateTime(2007-10-26T09:20:45Z)\]\]\_

An alternative solution is to directly use English sentences between quotes for wiki page names. This works well for new pages. For already existing pages in the WikiName format, it would however require the renaming of all existing links to a so-renamed page. \[HH\]

External links
--------------

Should the exact URL of external links be made explicit in Cocorico pages (as it is the case for instance in the Tools page)? General web practice is to bind URL to regular English expressions rather than binding it the text of the URL. If one really wants to know an URL, it generally appears anyway at the bottom of the browser when the mouse is over the link. \[HH\]

Use of table of contents
------------------------

My feeling is that table of contents are relevant on pages with proper elaborated contents. I don't think that they are necessary for pages that consists in a list of links. For instance, removing the table of contents from the [Cocorico's front page](CocoricoFrontPage) would remove what at the end is just a redundant information. \[HH\]

> Yes, on the front page it was redundant (removed now). -- [MiladNiqui](MiladNiqui)

Reference to individuals
------------------------

If one looks at the pages of [wanted pages](WantedPages), one sees several pages named after a individual. Wouldn't it be better to link to the existing (external) page of the persons cited rather than creating new stub pages for these individuals? \[HH\]

> Yes it is a good idea. But the stub pages are also created for users of this wiki when they edit a page (because their username will appear on the [RecentChanges](RecentChanges) page). In that case it might be good to put at least a link to the external page of the individual on the stub page. -- [MiladNiqui](MiladNiqui)

Organisation of the contents
============================

My opinion is that Cocorico has now grown enough to justify a step of reorganisation of the contents. I don't have a clear global idea of what to do but a few restructuration steps are certainly worth to be done.

Among other things, I'm thinking about grouping similar topics under a same heading (grouping for instance the contact links *nable* and *irc*; the documentation links [general documentation](Documentation), the [logical theory](TheoryBehindCoq) of Coq, extending the [source](CoqCustomizationHowTo) of Coq and documentation on [modules](Modules)).

I also wonder whether the front page could start with a short text, linking among others to the [page](ComparisonWithOtherSystems) (from the [CoqNewbie](CoqNewbie) page) that compares Coq to other similar systems. \[HH\]

Here is a new proposition for formatting the Coq topic available on the [Front page](CocoricoFrontPage).

|*The Coq Community* | *Documentation* | *Formalisations* | *Software* |
|---|---|---|---|
|[The newbie zone](CoqNewbie) | [Books and Manuals](Documentation)         |[Standard Library](StandardLibrary)         |[Interfaces](Tools)             |
|[Coq-club on Nabble](http://www.nabble.com/Coq-f2323.html)|[Tutorials](Tutorials)                     |[Formalized in Coq...](FormalizedAndVerified)|[Software Verification](Tools) |
|[irc channel](irc://irc.freenode.net/#coq)                |[Frequently asked questions](FrequentlyAskedQuestions) |[Coq pearls](CoqPearls)      |[Tactic plugins](Tools)             |
|[Coq in the classroom](CoqInTheClassroom)                |[Logical foundations](TheoryBehindCoq)                 |[Tactic pearls](LtacPearls)  |[Documentation tools](Tools)        |
|                                                         |[Misc. documentation](SpecializedDocumentation)        |[Project ideas](ProjectIdeas)| |
|                                                         |[About Coq code source](CoqSource)                     |[Coq's style](CoqStyle)      | |
|                                                         |[About This Wiki](AboutCocorico!)                     | | |

Notes: *About Coq source code* would link to a new page that includes CoqCustomizationHowTo\_ and [TheSource](TheSource); the page on [modules](ModuleSystem) would be in the (new) [Misc. documentation](SpecializedDocumentation) page; the [UserContribution](UserContribution) page would be integrated to the FormalizedAndVerified\_ page. The [TipsAndTricks](TipsAndTricks) page would be integrated to the FrequentlyAskedQuestions\_.

> Most of these are applied now. What should [Tutorials](Tutorials) point to? Right now it points to [CoqNewbie](CoqNewbie). -- [MiladNiqui](MiladNiqui) \[\[DateTime(2007-12-03T15:41:24Z)\]\]\_
