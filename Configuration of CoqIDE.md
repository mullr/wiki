The default key bindings of CoqIDE are often problematic because they conflict with the window manager. Moreover, the default bindings are not efficient at all: the most useful action requires pressing a combination of 3 keys... Fortunately, it is straightforward to update the bindings.

Configuring the alternative set of bindings
===========================================

(For Coq version &gt;= 8.4 only)

Close all running instances of CoqIDE, then download and install the modified configuration file as follows:

-   On Linux, copy the file [coqide.keys](files/coqide.keys) into the folder `~/.config/coq/`
-   On Windows, copy the file [coqide.keys](files/coqide.keys)_ either into the folder `%HOME%\.config\coq` if `HOME` is defined, or into the folder `C:\Program Files\Coq\config` (assuming you used the default installation path).
-   On MacOS, the alternative set of bindings has not been tested; see below how to modify the bindings yourself.

The alternative set of bindings
===============================

After you copied the modified configuration file, the new bindings are as follows:

\[Table not converted\]

\[Table not converted\]

How to manually modify the bindings
-----------------------------------

You can edit the binding files `coqide.keys` yourself. (It is located in `~/.config/coq/` or `C:\Program Files\Coq\config\`). To modify a binding, edit the corresponding line by removing the semi-column at the beginning of the line and changing the shortcut. Example:

\[Table not converted\]

Other tips for Coqide
=====================

**Copy-pasting**: to copy a piece of text from proof context or from the error message pannel, you cannot use the CTRL+C key binding, however the key binding CTRL+INSERT does work.

**Focus**: CoqIDE can be slowed down a lot by the Focus command. Do not use it. Instead, use "admit" to skip subgoals until you can view the one that you are interested in.
