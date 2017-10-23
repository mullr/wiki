Notes on migrating Coq wiki 
===========================

## Current situation ##

[cocorico](http://coq.inria.fr/cocorico) was up to now a [MoinMoin](https://moinmo.in/) wiki, installed on the same server as Coq website, located at Inria Rocquencourt.

## Proposed migration : Github wiki ##

Here is the new [proposed wiki](Home), which is a full translation of today's cocorico to github wiki.
More on it and its caveats and glitches below.

## Why moving ? ##

- Maintenance burden due to self-hosting. We used the Debian/Ubuntu package for MoinMoin, so install is easy, but configuration and backup is tricky, see for instance the misconfiguration which led to the loss of many attachments. And security alerts must be taken care of properly, even with things like unattended_upgrades.

- MoinMoin is doing the job, but not in an amazing way : the look-and-feel is somewhat outdated, the wiki syntax is quite different from other tools (such as markdown on github), the coq-captcha aren't great, no versioning of attachments, etc.

- Most of Coq development (including bug tracking) now happens on Github, so there's an opportunity to regroup more things there, and benefit from this uniformity (e.g. links between wiki/issues/code/..., same markup syntax, same accounts, etc).

- A few other goodies, like the ability to git clone the wiki repository, see its history, and (for those with access rights) push modifications, even on a large scale, without being obliged to go through the web interface.

## Caveat ##

I (Pierre Letouzey) do think that the above reasons outbalance the following points, but not everything is perfect with the Github solution. So discussion is open.

- First, there's the "political" aspect of having this wiki hosted on github, but this isn't "worse" than using github as bug tracker : all the data of this wiki can be retrieved via a simple `git clone`.

- Then, the migration itself is hard to perform. The only tool I found somewhat satisfactory is [moin2rst](https://github.com/mgaitan/moin2git.git), that converts MoinMoin to a git-based reStructuredText wiki. Then I used pandoc to convert to GFM (Github Flavored Markdown). This 2-step conversion wasn't perfect, even after some hacking of moin2rst, but that's close enough to finish the job by some manual editing (for instance on html tables). Once again, what I obtained is visible [here](Home). I consider it as quite ready already, even though some pages may still deserve some more polishing. 

- Note that the pages history has been preserved, but only the latest revision has been translated to markdown. What you get when browsing older revisions is still in MoinMoin syntax. Note also that deleted pages has not been converted. For Wiki archeology, you'll have to dig into a backup of Cocorico (ask me). 

- The github wiki is *very* poor in configuration options. Either all github users may edit your wiki, or you restrict your wiki to collaborators of your repository. That's all. No fancy ACL or whatever. But that seems ok for what we need. We may lack the possibility of turning a page into read-only mode, but at the same time, the github monitoring of accounts behaving as spammers seem pretty aggressive (as experienced during a test).

- Similarly, some features of MoinMoin do not seem to have counterpart in Github wiki: 
  - The RecentChanges page (we could replace it someday by a script)
  - The `<<TableOfContents>>` pragma at the top of a page, expanded by MoinMoin into a real table of content.
  - The various header pragma such as `#include` or `#redirect`. For redirection, we could use symlinks, see below.

- File setup:
   - the Github wiki is actually a git repository, that you can clone (eg `http://github.com/coq/coq.wiki.git`), edit and push (if you have enough rights). Be careful when pushing, there's no restriction to fast-forward commits, so you can `git push --force` and possibly break/loose the history.
   - In this repository, file `Foo.md` will be accessible at address `http://github.com/coq/coq/wiki/Foo`.
   - Other syntax formats are supported apart from markdown, but **please restrict yourself to markdown**, for uniformity reasons (help the editors, simplify any future migrations, etc).
   - An **important (and awkard) point** : directories in the git repository do **not** appear in the URL of wiki pages ! For instance file `A/B/Bar.md` has address `http://github.com/coq/coq/wiki/Bar`. Compared with MoinMoin,
that means that a few file basenames had to be edited to make them unique and significant, even without their directory part. But after a bit of practice, that does not seem to be that problematic.
   - For attachments and images, the directory part of the path is to be mentionned nonetheless. For the moment, I've regrouped everything in two directories `images` and `files`. See for example [HandMul](HandMul) and [CoqIW2017](CoqIW2017) pages.

- The CamlCase words aren't automatically considered as links in Github. The conversion process has sometimes failed to convert them to proper links, in that case a final _ may appear after a CamlCaseWord. Feel free to fix the few I may have left afterwards.

- To recover the syntax highlighting of code snippets, we'd better use the 3-backtick syntax followed by `coq` as language name, instead of the 4-space syntax that the conversion has produced.

- I already renamed some pages about tactics into names that were more wiki-compatible, prefixing them with Tactic. Feel free to object, or on the opposite continue in this trend.

- Little remark : in github tables (unlike MoinMoin), you must have a header row. See for instance [FormalizedAndVerified](FormalizedAndVerified) for an example of table.

- By the way, the page style of Github makes it difficult to create hugely larged tables, so I finally converted [Top100MathematicalTheoremsInCoq](Top100MathematicalTheoremsInCoq) into many sections.

## TODO ##

- Welcome pages : adapt / polish old pages about how to contribute, syntax, caveats as those listed above, etc.
- I already discarded many pages that were MoinMoin-specific (Help on syntax, etc), but there remain more to do, see for instance [Discussion_on_content_and_structure_of_Cocorico!](Discussion_on_content_and_structure_of_Cocorico!).
- Decide what to do with the `Users*` pages : I'm in favor of their removal, but in 1-2 cases we'd better ask since they have (a bit) of content. 
- Custom Sidebar and/or footer ?
- redirect existing wiki pages from `coq.inria.fr/cocorico/Foo` to `github.com/coq/coq/wiki/Foo`
- archive old pages : either as a read-only MoinMoin, or as a final dump to static html. This is important since page conversions haven't been 100% perfect, so we may want to look at the previous aspect of a page.

On these points, any help would be quite appreciated !

## References ##

- Tutorial on Github markdown syntax : <https://guides.github.com/features/mastering-markdown/>
- Spec of Github markdown : <https://github.github.com/gfm/>