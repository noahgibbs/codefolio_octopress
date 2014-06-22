---
layout: post
title: "Threads in Ruby"
date: 2014-06-22 14:01
comments: true
categories: 
---
Here's a video about threads in Ruby - how do you code them? What are the problems with them?
I'm planning a few more short videos about Ruby concurrency. I don't think enough people
have a good grasp of the tradeoffs and problems of running more than one chunk of code at
once, in Ruby or in general.


I'm also still learning <a href="http://www.techsmith.com/camtasia.html">Camtasia</a> and
the rest of the video toolchain. So I hope I'll look back in a few months and think,
"wow, this looks really bad now!"

In the mean time, enjoy! Here's a transcript:

<pre>
Ruby supports threads, of course. Modern Ruby, anything 1.9 and higher, uses
the normal kind of threads for your operating system, or JVM threads if you’re
using JRuby.

[next slide]

Here’s the code to make that happen.

The code inside the Thread.new block runs in the thread, while your main
program skips the block and runs the join.  “Join” means to wait for the
thread to finish - in this case, it waits up to 30 seconds since that’s what
we told it. With no argument, join will wait forever.

You’ll probably want a begin/rescue/end inside your thread to print a message
if an uncaught exception happens. By default, Ruby just lets the thread die
silently. Or you can set an option to have Ruby kill your whole program, but I
prefer to print a message.

In “normal” Ruby, Matz’s Ruby, there’s a Global Interpreter Lock. Two threads
can’t run Ruby code at the same time in the same process. So most Ruby threads
are waiting for something to complete, like an HTTP request or a database
query.

[next slide]

What are Ruby threads good for if there’s a global lock? In Matz’s Ruby,
you’ll mostly want to use them for occasional events. RabbitMQ messages,
timeouts, and Cron-style timed jobs are all good.

Since you can only have one thread doing real work in Ruby at once, threads
are best when your process is mostly idle.

JRuby and Rubinius users can chuckle here. Their Ruby handles multiple Ruby
threads working at the same time without a hiccup.

So what problems do you sometimes see with Ruby threads?

[next slide]

With the Global Interpreter Lock, threads can switch back and forth between
CPUs, sometimes very often. If you see Ruby threads performing horribly in
production with Matz’s Ruby or using way too much CPU, try locking the thread
down to a single CPU. Your operating system has commands for that — Google
them.

Next, if the main thread dies or finishes, your program ends.  That’s a
feature, but sometimes it’s surprising. To have your main thread of execution
stick around, use join on the other threads to let them finish.

And of course an unhandled exception in a child thread kills only the child
thread, and it does it completely silently.  Use a begin/rescue/end to print
errors to console or set the Ruby option to kill the main program when a child
thread dies from an unhandled exception.
</pre>
