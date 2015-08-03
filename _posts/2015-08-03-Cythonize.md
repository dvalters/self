---
layout: post
title: Cythonizing your Python files
tags: Python
---
if you have .pyx files in a python module, make sure to cythonise them first:

{% highlight python %}
from Cython.Build import cythonize
...
cythonized_files = cythonize(pyx_files)
{% endhighlight %}
