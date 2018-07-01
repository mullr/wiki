Setting up your development tools is important and may take time.
Here you find the recommended setup for most tools as text editors, VCS, …

- [Emacs](#emacs)
- [Vim](#git)
- [Git](#git)

## Emacs

### How to install and configure Merlin (for Emacs)

Install emacs using your package manager of choice.

Setup `merlin` from their [documentation on emacs from scratch](https://github.com/ocaml/merlin/wiki/emacs-from-scratch).



Try to open some `*.ml` file in Emacs, e.g.:

```
$ cd ~/git/coq
$ emacs toplevel/coqtop.ml &
```

Emacs display the following strange message:

```
The local variables list in ~/git/coq
contains values that may be safe (*).

Do you want to apply it?
```

Just press `!`, i.e. "apply the local variable list, and permanently mark these
values (\*) as safe."

Emacs then shows two windows:
- one window that shows the contents of the "toplevel/coqtop.ml" file
- and the other window that shows greetings for new Emacs users.

If you do not want to see the second window next time you start Emacs, just
check "Never show it again" and click on "Dismiss this startup screen."

The default key-bindings are described here:
    https://github.com/the-lambda-church/merlin/wiki/emacs-from-scratch

If you want, you can customize them by replacing the following lines:

```elisp
(define-key merlin-map (kbd "C-c C-x") 'merlin-error-next)
(define-key merlin-map (kbd "C-c C-l") 'merlin-locate)
(define-key merlin-map (kbd "C-c &") 'merlin-pop-stack)
(define-key merlin-map (kbd "C-c C-t") 'merlin-type-enclosing)
```

in the file `~/.opam/<opam version>/share/emacs/site-lisp/merlin.el` with what you want.
In the text below we assume that you changed the origin key-bindings in the following way:

```elisp
(define-key merlin-map (kbd "C-n") 'merlin-error-next)
(define-key merlin-map (kbd "C-l") 'merlin-locate)
(define-key merlin-map (kbd "C-b") 'merlin-pop-stack)
(define-key merlin-map (kbd "C-t") 'merlin-type-enclosing)
```

Now, when you press `Ctrl+L`, Merlin will show the
definition of the symbol in a separate window.  If you prefer to jump to the
definition within the same window, do this:
`<Alt+x> customize-group <ENTER> merlin <ENTER>`

```
Merlin Locate In New Window

  Value Menu

    Never Open In New Window

  State

    Set For Future Sessions
```

### Testing Merlin Configuration:

```
$ cd ~/git/coq
$ emacs toplevel/coqtop.ml &
```

- Go to the end of the file where you will see the "start" function.
- Go to a line where `init_toplevel` function is called.
- If you want to jump to the position where that function or datatype under the cursor is defined, press `<Ctrl+L>`
- If you want to jump back, type: `<Ctrl+B>`
- If you want to learn the type of the value at current cursor's position, type: `<Ctrl+T>`


### Enabling auto-completion in emacs

- [Install `company-mode`](http://company-mode.github.io/), a general
  autocompletion engine.

- View the [`merlin + company mode` section on the merlin emacs guide](https://github.com/ocaml/merlin/wiki/emacs-from-scratch#company-mode).
- The OCaml docs have a [get up and running section](https://ocaml.org/learn/tutorials/get_up_and_running.html)
  as well.

### Getting along with ocamldebug

The default ocamldebug key-bindings are described here.

  http://caml.inria.fr/pub/docs/manual-ocaml/debugger.html#sec369

If you want, you can customize them by putting the following commands:

Add to your `~/.emacs` file:
```elisp
(global-set-key (kbd "<f5>") 'ocamldebug-break)
(global-set-key (kbd "<f6>") 'ocamldebug-run)
(global-set-key (kbd "<f7>") 'ocamldebug-next)
(global-set-key (kbd "<f8>") 'ocamldebug-step)
(global-set-key (kbd "<f9>") 'ocamldebug-finish)
(global-set-key (kbd "<f10>") 'ocamldebug-print)
(global-set-key (kbd "<f12>") 'camldebug)
```

Let us try whether ocamldebug in Emacs works for us.
(If necessary, re-)compile coqtop:

```
$ cd ~/git/coq
$ make -j4 coqide printers
```

open Emacs:

```
emacs toplevel/coqtop.ml &
```

and type:

```
<F12> ../bin/coqtop.byte <ENTER>  ../dev/ocamldebug-coq <ENTER>
```

As a result, a new window is open at the bottom where you should see:

```
(ocd)
```

i.e. an ocamldebug shell.

1. Switch to the window that contains the `coqtop.ml` file.
2. Go to the end of the file.
3. Find the definition of the `start` function.
4. Go to the "let" keyword that is at the beginning of the first line.
5. By pressing <F5> you set a breakpoint to the cursor's position.
6. By pressing <F6> you start the bin/coqtop process.
7. Then you can:
 - step over function calls: <F7>
 - step into function calls: <F8>
 - or finish execution of the current function until it returns: <F9>.

Other ocamldebug commands, can be typed to the window that holds the ocamldebug shell.

The points at which the execution of Ocaml program can stop are defined here:

  http://caml.inria.fr/pub/docs/manual-ocaml/debugger.html#sec350


### Installing printers to ocamldebug

There is a pretty comprehensive set of printers defined for many common data types.
You can load them by switching to the window holding the "ocamldebug" shell and typing:

```
(ocd) source "../dev/db"
```



## Vim

### Indentation

```vim
autocmd FileType ocaml set expandtab
```

I'd love to know how to set up ocp-indent properly

### Merlin

Setup merlin by using the [Merlin wiki page for vim from scratch](https://github.com/ocaml/merlin/wiki/vim-from-scratch).

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




