---
layout: post
title: Ancestor pages in WP
category: php
tags: wordpress, cms
---

Though there is a built in `is_child()` function, there is no WP function to determine whether a page is a descendent of a particular ancestor page. This function does that and you can add it to your `functions.php` file.

{% highlight php %}
<?php
function is_tree($pid) 
	{
	//$pid = The ID of the ancestor page
	global $post; //load details about this page
	$anc = get_post_ancestors( $post->$pid );
	foreach($anc as $ancestor) 
	{
		if(is_page() && $ancestor == $pid) 
			{
			return true;
			}
	}
	if ( is_page() && (is_page($pid)) )
		{
		return true; // we’re at the page or at a sub page
		} 
	else 
		{
		return false; //we’re elsewhere
		}
	}
?>

//The above function needs to be placed in the functions.php file of your theme. Then, you call this function when you need to test the ancestry of a page:

<?php
if ( is_tree( "id" ) ) 
	{
	//then do some action
	}
?>

{% endhighlight %}
