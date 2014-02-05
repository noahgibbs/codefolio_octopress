---
layout: post
title: "MiniTest 3.3.0 breaks some things..."
date: 2012-07-27 20:45
comments: true
published: true
categories: 
meta:
  disqus_id: "http://codefol.io/posts/17"
---
MiniTest 3.3.0 seems broken in some (fairly simple-looking) cases that 3.2.0 didn't break.  The presenting error is below.

It's claiming that an auto-generated Test Suite doesn't have a "run" method.  I haven't <a href="https://github.com/seattlerb/minitest/commits/master">looked through enough diffs</a> to be sure what the problem is.

A simple workaround is to go back to MiniTest 3.2.0, possibly by adding a "~>3.2.0" to your Gemfile.

```
~/gems/minitest-3.3.0/lib/minitest/unit.rb:826:in `block in _run_suite': undefined method `run' for #<ArrayTest:0x007f859811fa10> (NoMethodError)
```

