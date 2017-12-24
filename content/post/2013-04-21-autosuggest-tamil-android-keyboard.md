---
title: Autosuggest for Tamil in Android Keyboard
author: yuvipanda
type: post
date: 2013-04-21T21:35:32+00:00
url: /autosuggest-tamil-android-keyboard/
content_columns:
  - 1
dsq_thread_id:
  - 1227031916
categories:
  - code
  - personal

---
<p style="text-align: center;">
  <a href="http://yuvi.in/blog/wp-content/uploads/2013/04/2013-04-22-02.57.36.png"><img class="aligncenter  wp-image-575" alt="Screenshot of Tamil autocomplete" src="http://yuvi.in/blog/wp-content/uploads/2013/04/2013-04-22-02.57.36-580x1031.png" width="348" height="619" srcset="http://yuvi.in/blog/wp-content/uploads/2013/04/2013-04-22-02.57.36-580x1031.png 580w, http://yuvi.in/blog/wp-content/uploads/2013/04/2013-04-22-02.57.36-508x904.png 508w, http://yuvi.in/blog/wp-content/uploads/2013/04/2013-04-22-02.57.36.png 720w" sizes="(max-width: 348px) 100vw, 348px" /></a>
</p>

Screenshot of Autosuggest working in Tamil on [my variant][1] of the Android keyboard. I&#8217;ve been working on this on and off for the last few months (this is also my final year project in college). I&#8217;ve ported all of the [jQuery.IME][2] languages to work on the keyboard natively. 

Now experimenting with Autosuggest. It only needs an appropriate dictionary now and we&#8217;ll be good to go. Currently I&#8217;m getting Autosuggest working only on Tamil, but the plan is to get it to work for all Indian languages. The method I am using (convert everything back to latin chars, then do autocorrect / autosuggest) means it should be trivial to extend to any transliteration based input method. 

Wheeee! This is very much a simple &#8216;celebratory&#8217; post. Will blog actual details soon.

 [1]: http://github.com/wikimedia/aosp-morelangs-ime
 [2]: https://github.com/wikimedia/jquery.ime