:warning: **Note:** This page was created to discuss the advantages and drawbacks of migrating from Bugzilla to another bug tracker. This was finally done in Oct, 2017 (see the [blog post](https://www.theozimmermann.net/2017/10/bugzilla-to-github/) describing the migration). We are now using GitHub issues.

|**Advantages of Bugzilla** | **Advantages of** GitHub **issues** |**Moving everything to gitlab.com** | **List here other bug trackers**|
|---|---|---|---|
|Status quo (necessarily simpler) |Issues are indexed by Google |freer than github | |
|Advanced bug state tracking (RESOLVED with &lt;reason&gt;, DUP, NEEDINFO, ...) |\#4553 will automatically link to the corresponding issue (or PR) |similar advantages as github vs bugzilla ||
|you can use deskzilla to create, modify and search bugs offline, and upload changes later |"This closes \#2782." in a commit message will automatically close the corresponding issue when the commit is merged |||
||Markdown support |||
||Possible to have a template for new issues and to show a link to CONTRIBUTING.md when this file exists | ||
||Easy to follow new bug reports (just watch the repository) |||
||Shared permission managements |||
||Shared milestones |||

**Drawbacks of Bugzilla** | **Drawbacks of** GitHub **issues** |**Moving everything to gitlab.com** | **List here other bug trackers**
-|-|-|-
Very hard to understand |Non-free software |github already has PRs and people's accounts (but GitLab allows logging in with GitHub account) |
No easy way to subscribe to new bug reports (you can subscribe to <https://lists.gforge.inria.fr/mailman/listinfo/coq-bugs-redist> but you'll need moderator approval) |No features for asking the reporter details about the machine used, the version, etc (but the template can play this role) | |
No way to edit comments |renumber all bugs; how to maintain correct referencing from outside or even from within the comments on bugs?| |
No mentions |cannot give people permissions to triage bugs without at the same time giving them permission to merge PRs and push Fixed by protecting branches. | |
Set-up needed to be indexed by Google. See <https://bugzilla.mozilla.org/robots.txt> | | |

See also <https://en.wikipedia.org/wiki/Comparison_of_issue-tracking_systems>
