---
layout: post
title: Redshift - rest your eyes
tags: utility
----

## f.lux

*f.lux* is a utility for Windows, Mac, and Ubuntu that automatically adjusts the colour of your monitor to simulate indoor lighting after sunset, and normal daylight during the day, reducing strain on the eyes if you use your computer in the evening.

## Redshift

For fedora, f.lux is not available (unless you compile ot from source), but an equally good alternative, *redshift* exists. It can be installed from the fedora repository with yum/dnf.

`dnf install redshift redshift-gtk`

The gtk package installs a GUI applet. You will need to tweak one file in your system for the applet to run correctly and detect your location automatically.

```
sudo vim /etc/geoclue/geoclue.conf
```
add the following lines at the end:
```
[redshift]
allowed=true
system=false
users=
```

And you are ready to go!
