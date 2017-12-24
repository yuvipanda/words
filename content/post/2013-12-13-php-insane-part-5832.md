---
title: PHP being insane, part 5832
author: yuvipanda
type: post
date: 2013-12-13T17:58:15+00:00
url: /php-insane-part-5832/
dsq_thread_id:
  - 2048691730
categories:
  - code
  - wiki

---
Somehow: `( $a && $b ) || ( $b && $c ) || ( $a && $c )`
  

  
Became: `$a ? ( $b || $c ) : ( $b && $c )`
  

  
Became: `count( array_filter( array( $a, $b, $c ) ) ) >= 2`

Became: `"$a$b$c" > 1`

God dammit PHP&#8230;

(from discussion among me, ^d, ori-l, bd808 and anomie on `#mediawiki-core` about how to represent &#8216;if at least 2 of three conditions are true&#8217;)