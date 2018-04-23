Installation from binaries
==========================

A binary installer for Windows is available at https://github.com/coq/coq/releases/latest
Since version 8.8, this installer also includes the possibility to install additional Coq packages (right now, only Bignums is provided).

Installation from sources
=========================

It is far from an easy task to compile Coq on Windows. Effort is currently under way to make it easier (see [#7157](https://github.com/coq/coq/issues/7157)).

Installation of Coq in a virtualized Linux
==========================================

Some features of Coq are not yet supported under Windows. This includes the native compiler and parallel proof processing in CoqIDE. If you want to take advantage of these features, you are advised to install GNU/Linux in a virtual machine and run CoqIDE from there.

1.  Install VirtualBox for Windows (open source edition).
2.  Allocate a virtual hard disk in VirtualBox (at least 4 GB).
3.  Install Ubuntu inside VirtualBox (there are many tutorials on the internet explaining this).
4.  Run the virtualized Ubuntu.
5.  From the virtualized Ubuntu, find the menu "Install Guest Additions" for smooth integration of keyboard and mouse.
6.  Activate either "Full-screen Mode" or "Seamless Mode" for obtaining a larger display.
7.  Install Coq following the [Installation of Coq on Linux](Installation%20of%20Coq%20on%20Linux) tutorial.

