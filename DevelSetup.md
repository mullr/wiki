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
$ git remote -v
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

in your `.gitconfig` or your `.git/config` can ensure that you do not push to `master` or a stable branch by mistake (if you have commit rights).

### PRs

To see the PRs add to your `.git/config`

```ini
[remote "upstream"]
	url = https://github.com/coq/coq.git
        fetch = +refs/pull/*/head:refs/remotes/upstream/pr/*
```




