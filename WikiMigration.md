Notes on migrating Coq wiki 
===========================

## Current situation ##

[cocorico](http://coq.inria.fr/cocorico) was up to now a [MoinMoin](https://moinmo.in/) wiki, installed on the same server as Coq website, located at Inria Rocquencourt.

## Propose migration : Github wiki ##

See the [current proof of concept](Home) of this migration to Github wiki. More on it and its caveats and glitches below.

## Why moving ? ##

- Maintenance burden due to self-hosting. We used the Debian/Ubuntu package for MoinMoin, so install is easy, but configuration and backup is tricky, see for instance the misconfiguration which led to the loss of many attachments. And security alerts must be taken care of properly, even with things like unattended_upgrades.

- MoinMoin is doing the job, but not in an amazing way : the look-and-feel is somewhat outdated, the wiki syntax is quite different from other tools (such as markdown on github), the coq-captcha aren't great, no versioning of attachments, etc.

- Most of Coq development (including bug tracking) now happens on Github, so there's an opportunity to regroup more things there, and benefit from this uniformity (e.g. links between wiki/issues/code/..., same markup syntax, same accounts, etc).

- A few other goodies, like the ability to git clone the wiki repository, see its history, and (for those with access rights) push modifications, even on a large scale, without being obliged to go through the web interface.

## Caveat ##

I (Pierre Letouzey) do think that the above reasons outbalance the following points, but not everything is perfect with the Github solution. So discussion is open.

- First, the migration itself is hard to perform. The only tool I found somewhat satisfactory is [moin2rst](https://github.com/mgaitan/moin2git.git), that converts MoinMoin to a git-based reStructuredText wiki. Then I used pandoc to convert to GFM (Github Flavored Markdown). This 2-step conversion wasn't perfect, even after some hacking of moin2rst, but that's close enough to finish the job by some manual editing (for instance on html tables). Once again, what I obtained is visible [here](Home).

- Note that the pages history has been preserved, but only the current revision has been translated to markdown. What you get when browsing older revisions is still in MoinMoin syntax.

- The github wiki is *very* poor in configuration options. Either all github users may edit your wiki, or you restrict your wiki to collaborators of your repository. That's all. No fancy ACL or whatever. But that seems ok for what we need. The github monitoring of account behaving as spammers seem pretty aggressive (as experienced during a test).

- The CamlCase words aren't automatically considered as links in Github. The conversion process has sometimes failed to convert them to proper links, in that case a final _ may appear after a CamlCaseWord. Feel free to fix the few I may have left afterwards.

- To recover the syntax highlighting of code snippets, we'd better use the 3-backtick syntax followed by `coq` as language name, instead of the 4-space syntax that the conversion has produced.





## TODO ##

- Welcome pages : adapt / polish old pages about how to contribute, syntax, caveats as those listed above, etc.
- redirect existing wiki pages from `coq.inria.fr/cocorico/Foo` to `github.com/coq/coq/wiki/Foo`
- archive old pages : either as a read-only MoinMoin, or as a final dump to static html. This is important since page conversions haven't been 100% perfect, so we may want to look at the previous aspect of a page.

