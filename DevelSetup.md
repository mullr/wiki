Setting up your development tools is important and may take time.
Here you find the recommended setup for most tools as text editors, VCS, …

- [Emacs](#emacs)
- [Vim](#git)
- [Git](#git)

## Emacs

### Indentation

### Merlin

## Vim

### Indentation

```vim
autocmd FileType ocaml set expandtab
```

I'd love to know how to set up ocp-indent properly

### Merlin

The [Merlin wiki page for vim](https://github.com/ocaml/merlin/wiki/vim-from-scratch) is pretty good.

## Git

### Remotes

Don't use `origin` for Coq's repo, but rather `origin` for your fork and `upstream` for the reference repo.
```
$ git remove -v
origin	git@github.com:you/coq.git (fetch)
origin	git@github.com:you/coq.git (push)
upstream	https://github.com/coq/coq.git (fetch)
upstream	https://github.com/coq/coq.git (push)
```

Adding

```ini
[remote]
        pushdefault = origin
```

in you `.gitconfig` or your `.git/config` can ensure that you do not push to `master` or a stable branch by mistake (if you have commit rights).

### PRs

To see the PRs add to your `.git/config`

```ini
[remote "upstream"]
	url = https://github.com/coq/coq.git
        fetch = +refs/pull/*/head:refs/remotes/upstream/pr/*
```

### White Space Linter

Put this snippet in your `.git/hooks/pre-push` hook and be done with it.

```shell
while read local_ref local_sha remote_ref remote_sha; do
...
base=`git merge-base $local_sha origin/master` 
if git diff --check $base $local_sha; then
	:
else
	echo "$0: Whitespaces! How dare you!"
	echo "$0: Please run: git rebase $base --whitespace=fix"
        echo "$0: If you don't fear global warming export MOCK_LINTER=1"
	if [ -z "$MOCK_LINTER" ]; then
		exit 1 # abort, fix, retry
	else
		: # Consequences:
	          # - the linter will complain
		  # - someone will tag "needs: fixing"
		  # - you'll complain that the linter is lame
		  # - you'll open yet another PR to kill the linter
		  # - wishy-washy discussion
		  # - someone will tag "needs: discussion"
		  # - then you'll fix the white spaces and push
		  # - a few more CI hours wasted because of the linter^Wyou
		  # - ice will melt and... well you saw the movies
		  # Please don't do that, rather install this pre-push hook
	fi
fi
...
done
```



