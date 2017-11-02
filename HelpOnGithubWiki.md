Help on Cocorico!, the Coq Wiki on Github
=========================================

A few advices about this wiki, mainly for wiki editors.

## Syntax ##

**Note:** Please always use the Github flavored [markdown syntax](https://guides.github.com/features/mastering-markdown/)
when editing this wiki. Truly, Github Wiki allows to choose different
formats for each page, but let's keep this wiki uniform, for editors
and administrators sanity. That's the default when editing a page through
the Github web interface (after clicking on the `Edit` or `New page` buttons),
so please leave it this way.

- Tutorial on Github markdown syntax : <https://guides.github.com/features/mastering-markdown/>
- Full spec of Github markdown : <https://github.github.com/gfm/>

## Before creating a new page ... ##

Before creating a new page, please use first the search tool
(the `find a page...` form in the right sidebar) to check whether
there already exists a page similar to what you intend to create.

Indeed, with this wiki, there's no warning when the name of the new
page is close to something that already exists. In particular, be
careful with misspelling of page names.

## History ##

- The global history of the whole Cocorico wiki is here:
  [Github history](_history). Note that old revisions of pages may
  still be in [MoinMoin](https://moinmo.in/) syntax.

- For a specific page, the mention `<n> revisions` just below
  the title is a link leading to the history of this page. Or you can
  add `/_history` to the page URL to get there. When on the history
  page, you can select two revisions and click on `Compare Revisions` to get
  a diff.

## Git ##

As mention at the bottom of the right sidebar, it is possible to
`clone this wiki locally`, as a git repository:

```
git clone https://github.com/coq/coq.wiki.git
```

Or for registered github users:

```
git clone git@github.com:coq/coq.wiki.git
```

A wiki page named `FooBar` will correspond to a file named `FooBar.md` in this
repository (`md` stands for `markdown`, the name of the syntax format).
The main page is [Home.md](Home). Images and attachments are in the `files` subdirectories.

This may indeed be a convenient way to browse the wiki files locally,
inspect their history, etc. You may even use this to push
modifications to the wiki if you have write access to the Coq
repository on github. In this case, please **never** push
modifications forcingly, only fast-forward ones. Forced modifications
will be undone by administrators as soon as they are noticed.

In case of strong popular request, we may propose someday a "pull request"
system for this wiki, since it could help large-scale modifications.

## Subdirectories ##

You may have noticed that all existing pages appear to be at toplevel:
the full URL of the page `FooBar` is `https://github.com/coq/coq/wiki/FooBar`,
and there's never anything between `wiki` and `FooBar`.

Actually, when accessing this wiki via its git repository (see above),
some files don't live at toplevel, but in various subdirectories. But these
subdirectories aren't reflected in the URL proposed by Github Wiki.
That's a bit awkward, but well, so be it.

As a consequences, please use unambiguous file names, even if you regroup
these pages in some subdirectories via the git interface. We suggest using
the dash `-` to prefix page names with what would normally be a directory
part. See for instance the various `Tactic-xyz` pages, that are actually
placed in the `Tactics` subdirectory.

Note that there's two situations where the subdirectory part of a filename
is visible in the final URL: images and attached files (e.g. pdf), see below.

## Images and attachments ##

TODO: could a basic user upload an image or an attachment through
the Github web interface ? Where does it go then ?

For images, the markdown syntax is `![textual description](files/image_name.png)`.
See page [HandMul](HandMul) for an example of wiki page with some images.
For now, all these images are in the `files` subdirectory of the git
repository, please keep it this way.

For attachment files (for instance `pdf`, or `v` scripts), simply put a local link,
whose markdown syntax is something like `[textual description](files/attachment_filename.pdf)`.
See pages  [CoqIW2017](CoqIW2017) and [UTF8Module](UTF8Module) for live examples of pages with attachment.
Here again, these attachment files are all in the `files` subdirectory of the
git repository of this wiki, please keep it this way.

For attachments of code (Coq scripts, ocaml files, etc), note that you could also
use the gist feature of Github (TODO: pointer).

## Compared with the earlier MoinMoin wiki... ##

- Apparently no features such as MoinMoin's `#include` or `#redirect` or `<<TableOfContents>>`.
  For redirections, you could use a symbolic link through git.

- All pages are public, no ACL to restrict access to some happy few.

- The CamlCase words aren't automatically considered as links in Github.
  It's up to you to turn them into links via the `[CamlCase](CamlCase)` syntax.

- In markdown, tables should have a header row, unlike in MoinMoin
  syntax. See for instance [FormalizedAndVerified](FormalizedAndVerified) for an example of table.

- The page style of Github makes it difficult to create hugely larged tables, so for instance [Top100MathematicalTheoremsInCoq](Top100MathematicalTheoremsInCoq) has now many sections instead of a big table.
