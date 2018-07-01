The default key bindings of CoqIDE are often problematic because they conflict with the window manager. Moreover, the default bindings are not efficient at all: the most useful action requires pressing a combination of 3 keys... Fortunately, it is straightforward to update the bindings.


The alternative set of bindings
===============================

The new bindings are then as follows:

|                          |     |
|--------------------------|-----|
|Execute until cursor      | F5  |
|Execute backward one step | F6  |
|Execute forward one step  | F7  |
|Execute to the end        | F8  |
|Start                     | F9  |
|Interrupt                 | F12 |


Configuring the alternative set of bindings
===========================================

(0) You need CoqIDE to have been executed at least once for the configuration file to exist.

(1) Before you make any change to these files, you MUST close all running instances of CoqIDE.

(2) You need find out the location of the configuration files `coqiderc` and `coqide.keys`:

-   On Linux, in `~/.config/coq/`
-   On Windows, either in `%HOME%\.config\coq` or in `C:\Program Files\Coq\config`
-   On Mac OS X, in `~/Library/Application\ Support/coq/`

(3) Edit the file `coqiderc` and make the following change:

|before | `modifier_for_navigation = "<Control>" ` |
|after  | `modifier_for_navigation = "" ` |

(4) Edit the file `coqide.keys` and insert the following lines at the bottom of the file:

```
(gtk_accel_path "<Actions>/Navigation/Go to" "F5")
(gtk_accel_path "<Actions>/Navigation/Backward" "F6")
(gtk_accel_path "<Actions>/Navigation/Forward" "F7")
(gtk_accel_path "<Actions>/Navigation/End" "F8")
(gtk_accel_path "<Actions>/Navigation/Start" "F9")
(gtk_accel_path "<Actions>/Navigation/Interrupt" "F12")
(gtk_accel_path "<Actions>/Navigation/Previous" "")
(gtk_accel_path "<Actions>/Navigation/Next" "")
```

(5) Open CoqIDE and test whether the new bindings work. They should appear in the Navigation menu.


Changing other bindings
=======================

If you use other commands frequently, you can customize their bindings. To that end, spot the line that corresponds to the desired command, then edit this line by removing the semi-column at the beginning of the line and changing the shortcut. Example:

|       |     |
|-------|-----|
|before | `;(gtk_accel_path "/Navigation/_Go to/" "<Control><Alt>Right")` |
|after  | `(gtk_accel_path "/Navigation/_Go to/" "F5")`                |


Troubleshooting
===============

Please report to @charguer in case of issues.
