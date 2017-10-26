Building Coq trunk + native CoqIDE under Mac OS X
=================================================

This is done under 10.6 using macports, the whole compilation processes can take several hours.

We are going to compile a version of GTK that uses native rendering so we don't need X11.app.

If you've already installed `cairo`, `pango`, `gtk` or any of the packages below, and they are not of the `+no_x11` and `+quartz variant`, you need to "port uninstall" them first.

So, to get started:

```
sudo bash
port install -v cairo +no_x11 +quartz
port install -v pango +no_x11
port install -v gtk2 +no_x11 +quartz
port install -v libgnomui +no_x11
port install -v ocaml
port install -v camlp5
port install -v lablgtk2
```

Then, as of 1.5.2011, the `ige-mac-integration` package is broken but easily fixed. The checksums fail, probably because the developer replaced the archives without bumping the version number or notifying macports.

In any case, in `/opt/local/var/macports/sources/rsync.macports.org/release/ports/devel/ige-mac-integration/`

open `Portfile`, and modify the checksums to read:

```
checksums       md5     56eca21af5ac5ef39cf306f08c11ea8c \
                sha1    235ee6915299340dc7a4ea301996521be99e7eef \
                rmd160  0a2bcf4f7125b7b0ed2255ec41d94df18b91f6e9
```

So install that, `port install ige-mac-integration`.

Then, in the coq-trunk checkout, `./configure -opt -local` and `make` it. You can then start the Coq IDE bin/coqide!

Unicode
-------

However, I my case coqide complained about missing locales:

```
(process:25614): Gtk-WARNING **: Locale not supported by C library.
    Using the fallback 'C' locale.
```

This is a problem as the 'C' locale doesn't support unicode, and a lot of our source uses unicode symbols.

My locale settings look like:

```
LANG=
LC_COLLATE="C"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="C"
LC_MONETARY="C"
LC_NUMERIC="C"
LC_TIME="C"
LC_ALL=
```

Running `locale -a` shows me all installed locales, and the `en_US.UTF-8` is amongst them!?.

I don't really understand what the problem is. In any case, one this that works for me is:

```
export LC_ALL="en_US.UTF-8"
```

This automatically overrides all other locale settings:

```
LANG=
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
```

Then coqide just works. There is one final problem, fonts!

Install either [Dejavu Sans](http://dejavu-fonts.org/wiki/Main_Page) or [GNU Freefont](http://www.gnu.org/software/freefont/), we use proportional fonts.

Enjoy!

[Installation of Coq](Installation%20of%20Coq)
