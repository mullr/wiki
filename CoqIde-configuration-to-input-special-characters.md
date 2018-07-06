(Part of [[the Coq FAQ]])

### What is CoqIde?

CoqIde is a GTK-based GUI for Coq.

### How to enable Emacs keybindings?

If in Gnome, run the gnome configuration editor (`gconf-editor`) and set key `gtk-key-theme` to `Emacs` in the category `desktop/gnome/interface`.

Otherwise, you need to find where the `gtk-key-theme-name` option is located in your configuration, and set it to `Emacs`. Usually, it is in the `$(HOME)/.gtkrc-2.0` file.

### How to enable antialiased fonts?

Set the `GDK_USE_XFT` variable to `1`. This is by default with `Gtk >= 2.2`. If some of your fonts are not
available, set `GDK_USE_XFT` to `0`.

### How to use those Forall and Exists pretty symbols?

Thanks to the notation features in Coq, you just need to insert these lines in your Coq buffer:

```coq
Notation "∀ x : t, P" := (forall x:t, P) (at level 200, x ident).
Notation "∃ x : t, P" := (exists x:t, P) (at level 200, x ident).
```

Copy/Paste of these lines from this file will not work outside of CoqIde. You need to load a file containing these lines or to enter the ∀ using an input method (see [below](#how-to-define-an-input-method-for-non-ascii-symbols)). To try it, just use `Require Import utf8` inside CoqIde. To enable these notations automatically start CoqIde with `coqide -l utf8`.

In the `ide` subdirectory of the Coq library, you will find a sample `utf8.v` with some pretty simple notations.

### How to define an input method for non ASCII symbols?

* First solution: use iBus:
- type `sudo apt-get install ibus-table-latex`
- then you must log out and log back in
- open "system settings" panel, go to menu "text entry"
- click the "+" button to add a new input source
- select "Other (LaTeX) (IBus)"
- look at which shortcut is registered for switching languages;
  alternatively, you can switch language from the global menu bar
  by clicking on the some icon saying, e.g. "Us" or "Fr".
- When LaTex input is selected, typing a backslash will trigger
  a completion box. Type the first letters, then type space to validate.
- For a simple backslash, just type backslash then space.

Alternatively, you may use another input method editor such as SCIM.


* Second solution: type `<CONTROL><SHIFT>2200` to enter a forall in the script widow. 2200 is the hexadecimal code for forall in unicode charts and is encoded as in UTF-8. 2203 is for exists. See http://www.unicode.org for more codes.

* Third solution: rebind `<AltGr>a` to forall and `<AltGr>e` to exists. Under X11, one can add those lines in the file `/.xmodmaprc`:

```
! forall
keycode 24 = a A a A U2200 NoSymbol U2200 NoSymbol
! exists
keycode 26 = e E e E U2203 NoSymbol U2203 NoSymbol
```

and then run `xmodmap /.xmodmaprc`. 

### How to define simple shortcuts for greek letters?

You can register a key to switch the keyboard to greek letters for the next keystroke. For example, to register the key "F12", execute in a terminal:
```
  xmodmap -e 'keycode 96 = dead_greek dead_greek dead_greek dead_greek'
```

If you like to use another key, you can find its code by typing the command `xmodmap -pke`.

### How to customize the shortcuts for menus?

Two solutions are offered:

* `Edit $XDG_CONFIG_HOME/coq/coqide.keys` (which is usually `$HOME/.config/coq/coqide.keys`) by hand; or
* if your system supports it, from CoqIde you may select a menu entry and press the desired shortcut.

### What encoding should I use? What is this `\x{iiii}` in my file?

The encoding option is related to the way files are saved. Keep it as UTF-8 until it becomes important for you to exchange files with non UTF-8 aware applications. If you choose something else than UTF-8, then missing characters will be encoded by `\x{....}` or `\x{........}` where each dot is a hex digit. The number between braces is the hexadecimal UNICODE index for the missing character.

### How to get rid of annoying unwanted automatic templates?

Some users may experience problems with unwanted automatic templates while using Coqide. This is due to a change in the modifier keys available through GTK. The easiest way to get rid of the problem is to manually edit your `coqiderc` file (either `/home/<user>/.config/coq/coqiderc` in Linux, or `C:\Documents and Settings\<user>\.config\coq\coqiderc` in Windows) and replace any occurrences of `MOD4` with `MOD1`.