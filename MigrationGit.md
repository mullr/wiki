= Migrating the coq repository from svn to git =

Author: Pierre Letouzey, with many other contributors (Enrico, Arnaud, Matthieu, Hugo...).

{{{#!wiki red/solid
Note : this page is a wiki, please edit it to integrate your suggestions, remarks, criticism.
Just ensure that your notes are visible, for instance by putting them into colored blocks
like this one. In complement, you can also drop a message to `coqdev`.
}}}

== Previous situation ==

Earlier, the official read-write repository of coq was a svn one on gforge.inria.fr.
We already add an existing git clone of the coq svn
repository, created and maintained via git-svn up to now :
{{{
 git://scm.gforge.inria.fr/coq/coq-svn.git
}}}
This clone was mirrored on github :

 https://github.com/coq/coq.git

Many persons had cloned either of these repository and proposed
their own extensions / experiments / ... on top of them.


== Which content for the official git repository ? ==

We decided to reuse the content of these existing git clones.

==== Pros: ====

 * This clone has been in activity for some years now, we aren't aware of any issues with it.

 * It's quite complete, for instance all v8.x branches are there. 

 * For all the persons already using these repositories, keeping it means no tedious rebase to perform.

==== Cons: ====

 * Authorship. Up to now, the authors of the commits are mentionned via their gforge login, and via a fake email :
 {{{   
   myname <myname@85f007b7-540e-0410-9357-904b9bb8a0f7>
 }}}
 This isn't really pretty, and won't be coherent with commits after the migration to git, for instance 
 {{{
   My Name <my.name@inria.fr>
 }}}
 But after all, this is just an instance of email changes for a same individual, and we'll probably have more of such changes in the future too. We have added to the archive a `.mailmap` file that allows to link the various identities of a given person, and display their credits correctly in `git shortlog` (and also `git log` on recent version of git). See `man git-shortlog` for more detail.

 Last remaining question : could such a `.mailmap` induce more spams ? It is meant to contain cleartext emails, and will probably be accessible on the web via the gitweb viewers. For the moment, we placed in it pseudo-emails login@gforge, we'll update them to true emails only for recent commiters (or on request).


== The new repository ==

We decided to continue using gforge.inria.fr for the hosting of the official
coq repository. In particular, all gforge accounts with commit rights
on the earlier svn archive are still able to push commits on the git
archive.

The url of the new repository is : 
{{{
 git://scm.gforge.inria.fr/coq/coq.git
}}}
This url is for the anonymous access, for pushing commits you'll need to rather use:
{{{
 git+ssh://yourname@scm.gforge.inria.fr/gitroot/coq/coq.git
}}}
Of course, the github mirror is still maintained.
There is also an anonymous access via an https url if necessary :
{{{
 https://gforge.inria.fr/git/coq/coq.git
}}}
But note that using this https protocol might not work out-of-the-box due to issues with the ssl certificate of gforge.inria.fr, more details in the FAQ (search for "ssl"). A workaround is to set the environment variable "GIT_SSL_NO_VERIFY=true" in your shell, at least during the git operations.

== The migration itself ==

The switch has been done on '''Tuesday, 19 November 2013'''.

For memory, here are the main steps used during the transition.
More information on the process in the documentation and FAQ of
gforge.inria.fr.

 1. First, the svn archive has been made read-only that day (via a pre-commit
 hook rejecting all new commits). Then this archive has been backuped
 somewhere else just in case.

 2. Then we stopped the cron task that runs git-svn and pushed updates
 to the existing git clones (on gforge and github).

 3. Then we asked for the svn=>git switch on the gforge interface
 (tab "source", sub-tab "admin"). This triggers a script that
 runs up to 6 hours according to the FAQ. This script initializes
 an empty coq.git repository somewhere on the gforge server, and
 adapts the "source" pages of the project (with a gitweb viewer,
 etc).

 3. We pushed to this coq.git repository all the content of coq-svn.git

 4. Some setup: in particular we forbid "non-fastforward push"
 (e.g. destructive, non strictly increasing change in the archive).
 See guidelines below.

 5. The mailing list coq-commits announcing each commit has been adapted
 (cf. FAQ + gforge bug ticket #15388).

 6. Tests : attempt to push a commit to check everything is all right
 (archive, gitweb, coq-commits)

 7. We removed the old svn repository : this way, nobody will stay by mistake
 on a not-evolving-anymore repository of Coq.

 8. Update any mention of the svn archive, especially on coq.inria.fr

 9. The mirroring to the github archive has been restored


== Git usage and guidelines ==

==== Basic use ====

For the developer, this isn't a complete revolution. `svn checkout` is now `git clone`, and the usual cycle:
{{{
svn update && emacs && make && svn commit
}}}
is just replaced by:
{{{
git pull && emacs && make && git commit && git push
}}}
For those not familiar with git, note the difference between `git commit`
(recording your modification to a local commit) and `git push`
(transfering this commit to the remote repository).

==== Git documentation ====

Some documents about git:

 http://git.or.cz/course/svn.html

 http://git-scm.com/book

 https://github.com/pluralsight/git-internals-pdf/releases/download/v2.0/peepcode-git.pdf

==== Workflow ====

We keep for now the same workflow as earlier : one central
repository, many commiters having access to this repository.

We also intend to keep the same principle as with svn : once a commit
reaches the central repository, it stays there forever. By default,
git provides many destructive features (history rewriting, commit
reworking, etc). It's perfectly fine to use them on your computer,
but not on commits already published, otherwise the other users
will encounter issues during their next `git pull`. To avoid this
situation, our gforge repository will be configure to accept only
push of "fast-forward" commits (i.e. commits that only adds on top
of commits already on the server). Note that this doesn't imply
a linear history, since a merge of a branch can be fast-forward.

==== Advices ====

 * Please fix reasonable authorship in your commits, e.g. `my.name@inria.fr`. See the identity section in:

 http://git-scm.com/book/en/Getting-Started-First-Time-Git-Setup

 * Please try to keep the history as linear as possible to ease its study. For works of moderate size, this means doing a `git rebase` on top of the trunk before pushing to gforge. When working in this mode, it could be handy to consider the option `--rebase` to `git pull`. Now, for more important development, it's fine to use of the merge abilities of git rather than rebase.

 * When preparing the push of a feature, try to separate your work in many atomic single-purpose commits. This can be done a posteriori via `git rebase -i ...`. Each commit you submit should be compilable (this helps greatly when locating issues via git-bisect). For that you may consider using for instance `git rebase -i --exec make`. A good habit is to prepare your non-trivial changes in a short-term local branch that wou'll rebase on top of trunk (or merge with) when things are ready for showtime.

 * If you want to push your own branches to the gforge repository, that's probably ok. This was done in the past with the svn repository. Simply, with git using a personal repository somewhere (e.g. on github or similar) could be quite more convenient.

 * Do not try to modify this gforge git repository in any other way than `git push`, unless a) you've contacted us first and b) you know exactly what you're doing. Git is quite powerful, but also full of ways to shoot in your own foot. Gforge has a proper backup policy, but let's try to avoid using it!

== Misc ==

==== Coqbenchs ====

The current coqbench will have to be slightly adapted :

 * Use `git pull` instead of `svn up`

 * mention git's SHA1 hashrefs instead of svn's revision number. Normally the first 6 or 7 chars of the SHA1 are enough to have uniqueness.

==== User Contribution Archive ====

This contributions are currently stored in a separate svn repository. We also plan to do something about this repository, but no definite plan nor migration date yet. First, let's do this migration of coq sources. Moreover, for contribs we probably want a notion of sub-repository, one per contrib.

==== Coqbugs ====

In coqbugs, we frequently refer to some specific commit (mainly to
specify when a bug has been fixed).

 * We'll have now to use git's hashref instead of svn's revision number. Here again the first 6 or 7 chars of the SHA1 should be enough to avoid ambiguities. It could be good to mention the date of the commit, since the hashs aren't ordered as the revisions were.

 * When looking at old messages, and wondering which commit is `r12345`, just do a `git log --grep=trunk@12345`. Indeed, git-svn has added a status line containing the branch and the revision in each log message of each commit.


==== External developpers ====

It will be easier now to propose patch when not being an authorized
commiter, either :

 * prepare a clone of our repository with your patch on top
 
 * prepare a patchset via `git format-patch`

 * use the pull-request feature of github (see below)

And then warn some coq developper or the whole coqdev.

When the owner of the contribution (typically you or your employer) isn't Inria or an Inria partner, you might need to fill first a copyright delegation form. Of course you'll remain credited as the author of the contribution. 

==== Github ====

Concerning pull requests made via github:

 * The notification should reach the coqdev mailing list now (thanks to
   a automatic forward by P. Letouzey's mailer).

 * To retrieve / review / apply pull requests, it's convenient to add the github repository as "remote" to yours. For instance, place:
 {{{
 [remote "github"]
        url = git@github.com:coq/coq.git
        fetch = +refs/heads/*:refs/remotes/github/*
        fetch = +refs/pull/*/head:refs/remotes/github/pr/*
 }}}
 to your `.git/config`, then `git remote update` will automatically fetch any pull requests on the github repo. You can then do things like `git cherry-pick github/pr/123` 
