#title Installation of Coq on Windows

== Installation from binaries ==

 1. [[http://coq.inria.fr/download|Download]] the binaries for Windows. (They are only available for official releases.)
 1. Execute the binary
 1. Run CoqIDE

== Installation from sources ==

It is far from an easy task to compile Coq on Windows. Do not attempt unless you are a real Windows guru.
If you need to work with non-released versions of Coq, or if you simply want to make your life easier, 
you may consider installing Coq into a virtualized Linux, as described below. 

== Installation of Coq in a virtualized Linux ==

Using virtualization, you can get a linux environment fully-integrated on your Windows desktop with very decent performances.
It's entirely free, it will take you less than an hour to set up, and it will compile or install any version of Coq and will give you a nice CoqIDE that will likely run faster than that for Windows.

 1. Install VirtualBox for Windows (open source edition)
 1. Allocate a virtual hard disk in VirtualBox (at least 4 Go)
 1. Install Ubuntu inside VirtualBox (there are many tutorials on the internet explaining this)
 1. Run the virtualized Ubuntu
 1. From the virtualized Ubuntu, find the menu "Install Guest Additions" for smooth integration of keyboard and mouse
 1. Activate either "Full-screen Mode" or "Seamless Mode" for obtaining a larger display
 1. Install Coq following the [[Installation of Coq on Linux]] tutorial


 
