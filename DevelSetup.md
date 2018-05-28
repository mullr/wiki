Setting up your development tools is important and may take time.
Here you find the recommended setup for most tools as text editors, VCS, …

- [Emacs](#emacs)
- [Vim](#git)
- [Git](#git)

## Emacs

Configuration written with [use-package](https://jwiegley.github.io/use-package/).

I use [straight](https://github.com/raxod502/straight.el/) for package management, autoload behaviour may be
slightly different with package.el.

[Tuareg](https://github.com/ocaml/tuareg) for syntax highlighting / general major mode stuff
[Merlin](https://ocaml.github.io/merlin/) for jump to definition
[Flycheck](http://www.flycheck.org/en/latest/) (using merlin) for online error checking
``` emacs-lisp
(use-package tuareg
  :defines (tuareg-mode-hook)
  :mode (("\\.ml[4ipl]?\\'" . tuareg-mode)
         ("[./]opam_?\\'" . tuareg-opam-mode)
         ("\\(?:\\`\\|/\\)jbuild\\'" . tuareg-jbuild-mode)
         ("\\.eliomi?\\'" . tuareg-mode))
  :init
  (defun tuareg-reset-indent ()
    "Reset comment style for tuareg mode"
    (setq-local comment-style 'indent))
  (add-hook 'tuareg-mode-hook #'tuareg-reset-indent)

  (push ".ml.d" completion-ignored-extensions)
  (push ".mli.d" completion-ignored-extensions))

(use-package merlin
  :diminish
  :defines (merlin-locate-preference)
  :commands (merlin-mode merlin-locate)
  :init
  (add-hook 'tuareg-mode-hook #'merlin-mode)
  :config
  ;; Disable Merlin's own error checking, we use flycheck
  (setq merlin-error-after-save nil))

(use-package flycheck-ocaml
  :after merlin
  :config
  ;; Enable Flycheck checker
  (flycheck-ocaml-setup))
```

### Indentation

Use ocp-indent https://www.typerex.org/ocp-indent.html

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




