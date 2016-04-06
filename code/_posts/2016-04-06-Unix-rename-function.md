---
layout: post
title: Linux `rename` function
---

## `rename`

Rename is a function in many (but not all) distributions of linux. It is very handy and has simple syntax. For example to rename parts of filenames in a folder, you can do this:

```console
rename ABC XYZ ABCfile.txt
```
It will rename part of the filename. It's handyness comes to the fore when you want to do rename a bunch of files en-masse, e.g.

```console
ls
>> ABCfile.in
>> ABCfile.out
>> ABCfile.shake
>> ABCfile.itallabout

rename ABC XYZ ABCfile.*

ls
>> XYZfile.in
>> XYZfile.out
...
```
Great when you've accidentally created hundreds of files all with the wrong name or extension.
