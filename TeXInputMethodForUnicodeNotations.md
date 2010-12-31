## page was renamed from UimAndUnicodeNotations

= In Emacs =

Using Emacs and Proof General, Unicode symbols can be conveniently entered using the ''TeX'' [[http://www.gnu.org/software/emacs/manual/html_node/emacs/Select-Input-Method.html|input method]].

Just do {{{M-x set-input-method}}} and choose {{{TeX}}}. Unicode symbols can then be entered using TeX macros, e.g. "{{{\beta}}}" for "β", "{{{_1}}}" for "₁", "{{{\circ}}}" for "∘", etc.

To make this happen automatically, add the following line to your {{{.emacs}}} file:

{{{
  (add-hook 'proof-mode-hook (lambda () (set-input-method "TeX") ))
}}}

= In CoqIDE (using UIM on POSIX systems) =

On CoqIDE, under Unix systems (Linux, BSD, MacOS X), the ''TeX'' input method is also available thanks to the [[http://code.google.com/p/uim/|UIM]] input method library.

You need ''uim'' 1.5.x or 1.6.x installed.

With ''uim 1.6.x'', the TeX input method works out of the box

To configure ''uim'', execute the command {{{uim-pref-gtk}}} as a regular user. In the ''Global Settings'' group set the default Input Method to ''ELatin'' (don’t forget to tick the checkbox ''Specify default IM''). In the ''ELatin'' group set the layout to ''TeX'', and remember the content of the ''[ELatin] on'' field (by default ''<Control>''). You can now execute CoqIDE with the following command (assuming you use a Bourne-style shell):


# the next line tells to use ''uim'' as default input method framework (otherwise, you'll have to choose manually the input method from CoqIDE by using the button-right menu) 

$ export GTK_IM_MODULE=uim  

# Start coqide

$ coqide

If not already activated, activate the ''ELatin Input Method'' with "{{{Ctrl-\}}}", then type the sequence "{{{\beta}}}". You will see the sequence being replaced by β as soon as you type the "{{{a}}}".

With ''uim 1.5.x'', the TeX input method is not included and you need first to install it. Take the attached files [[attachment:coqide-custom.scm]], [[attachment:coqide-rules.scm]] and [[attachment:coqide.scm]] and install them in the repository of input methods for ''uim'' (typically {{{/usr/share/uim}}} if uim was installed using a standard Linux distribution). Call first the command {{{uim-register --register coqide}}} to register the new files, then, proceed as above, except that you have to select ''CoqIDE'' instead of ''ELatin'' in the ''Global Settings'' of {{{uim-pref-gtk}}}. If not already done automatically, you might have first to {{{edit}}} the set of ''Enabled input methods'' to add ''CoqIDE'' to this set.

Many thanks to Vincent Gross for making this input method available.

= Alternative input methods =

See [[XComposeAndNotations|XCompose and notations]] for using the XCompose method (XIM) under X-windows.
