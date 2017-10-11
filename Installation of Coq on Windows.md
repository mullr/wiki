Windows binaries are distributed with each official release of Coq.

Installation from binaries
--------------------------

1. Download_ the installer for Windows.

#. Run the installer

#. `Configure the key bindings`_ (optional but strongly recommended)

#. Run CoqIDE

Installation from sources
-------------------------

It is far from an easy task to compile Coq on Windows. Do not attempt unless you are a real Windows guru. If you need to work with non-released versions of Coq, or if you simply want to make your life easier,  you may consider installing Coq into a virtualized Linux, as described below. 

Installation of Coq in a virtualized Linux
------------------------------------------

Using virtualization, you can get a linux environment fully-integrated on your Windows desktop with very decent performances. It's entirely free, it will take you less than an hour to set up, and it will compile or install any version of Coq and will give you a nice CoqIDE that will likely run faster than that for Windows.

1. Install VirtualBox_ for Windows (open source edition)

#. Allocate a virtual hard disk in VirtualBox_ (at least 4 Go)

#. Install Ubuntu inside VirtualBox_ (there are many tutorials on the internet explaining this)

#. Run the virtualized Ubuntu

#. From the virtualized Ubuntu, find the menu "Install Guest Additions" for smooth integration of keyboard and mouse

#. Activate either "Full-screen Mode" or "Seamless Mode" for obtaining a larger display

#. Install Coq following the `Installation of Coq on Linux`_ tutorial

.. ############################################################################

.. _Download: http://coq.inria.fr/download

.. _Configure the key bindings: ../Configuration of CoqIDE

.. _VirtualBox: ../VirtualBox

.. _Installation of Coq on Linux: ../Installation of Coq on Linux

