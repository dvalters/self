---
layout: post
title:  "Some php menu logic stuff"
date:   2015-07-07 21:42:05
categories: php snippet
---

WordPress, via the Menu Logic widget, lets you customise when menus are displayed on certain pages based on some simple php that you add to `functions.php`.

{% highlight php startinline %}
global $post; 
return ((is_page('33'))  ||  ($post->post_parent=="33")  );
{% endhighlight %}

This makes the menu only appear on the page with ID 33 (annoyingly, you have to go to 'edit page' to find these unique ID numbers. It will also display on the pages that are child pages of post #33.
