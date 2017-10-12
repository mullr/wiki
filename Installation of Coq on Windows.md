Windows binaries are distributed with each official release of Coq.

Installation from binaries
==========================

1.  [Download](http://coq.inria.fr/download) the installer for Windows.
2.  Run the installer
3.  [Configure the key bindings](Configuration%20of%20CoqIDE) (optional but strongly recommended)
4.  Run CoqIDE

Installation from sources
=========================

It is far from an easy task to compile Coq on Windows. Do not attempt unless you are a real Windows guru. If you need to work with non-released versions of Coq, or if you simply want to make your life easier, you may consider installing Coq into a virtualized Linux, as described below.

Installation of Coq in a virtualized Linux
==========================================

Using virtualization, you can get a linux environment fully-integrated on your Windows desktop with very decent performances. It's entirely free, it will take you less than an hour to set up, and it will compile or install any version of Coq and will give you a nice CoqIDE that will likely run faster than that for Windows.

1.  Install [VirtualBox](VirtualBox) for Windows (open source edition)
2.  Allocate a virtual hard disk in [VirtualBox](VirtualBox) (at least 4 Go)
3.  Install Ubuntu inside [VirtualBox](VirtualBox) (there are many tutorials on the internet explaining this)
4.  Run the virtualized Ubuntu
5.  From the virtualized Ubuntu, find the menu "Install Guest Additions" for smooth integration of keyboard and mouse
6.  Activate either "Full-screen Mode" or "Seamless Mode" for obtaining a larger display
7.  Install Coq following the [Installation of Coq on Linux](Installation%20of%20Coq%20on%20Linux) tutorial

