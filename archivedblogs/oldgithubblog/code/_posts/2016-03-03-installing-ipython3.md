---
layout: post
title: Installing an IPython 3 environment for ipynotebooks
tags: python3 python
category: python
---

### What I wanted to install

IPython 3 notebook environment with matplotlib and NumPy

### Prerequisites

There are a lot of prerequisites that are hard to figure out (and nobody seems to have written this down anywhere!)

{% highlight console %}
dnf install rpm-build \
            redhat-rpm-config \
            python3-devel \
            libpng-devel \
            freetype-devel
{% endhighlight %} 

I would get frequent install fails using pip without having these packages!

You may also need to update your pip installer and setuptools. (pip is the Python package manager)

{% highlight console %}
pip3 install --upgrade setuptools
pip3 install --upgrade pip
{% endhighlight %} 

Finally, you are ready to install matplotlib! (NumPy was less problematic)

{% highlight console %}
pip3 install matplotlib
{% endhighlight %} 


