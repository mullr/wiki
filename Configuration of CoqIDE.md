#title Configuration of CoqIDE 

== Fixing the key bindings ==

The default key bindings of CoqIDE are not efficient and moreover they usually conflict with bindings from the window manager. Fortunately, it is not hard to change them. Simply download a modified configuration file:
 * For Coq >= 8.4, copy the file '''[[attachment:coqide.keys]]''' into the folder '''~/.config/coq/ ''' (on Windows, C:\Program Files\Coq\config\)
 * For Coq <= 8.3, copy the file [[attachment:.coqide.keys]] into your home folder

The new bindings, which will boost your productivity, are then as follows:

||Execute until cursor||F5||
||Execute backward one step||F6||
||Execute forward one step||F7||
||Execute to the end||F8||

||Run make||F9||
||Reach next error||F10||
||Interrupt execution||F11||
||Reset execution||F12||

=== Custom bindings ===

If you want to edit the binding files yourself, you can change a binding by editing a line and removing the semi-column at the beginning of the line. For example, change as follows:
||before||`;(gtk_accel_path "/Navigation/_Go to/" "<CTRL><ALT>Right")`||
||after|| `(gtk_accel_path "/Navigation/_Go to/" "F5")`||


== Other tips for Coqide ==

'''Copy-pasting''': to copy a piece of text from proof context or from the error message pannel, you cannot use the CTRL+C key binding, however the key binding CTRL+INSERT does work.

'''Focus''': CoqIDE can be slowed down a lot by the Focus command. Do not use it. Instead, use "admit" to skip subgoals until you can view the one that you are interested in.
