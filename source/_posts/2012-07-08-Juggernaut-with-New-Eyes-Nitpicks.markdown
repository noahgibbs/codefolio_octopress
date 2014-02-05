---
layout: post
title: "Juggernaut with New Eyes - Nitpicks!"
date: 2012-07-08 16:06
comments: true
published: true
categories: 
meta:
  disqus_id: "http://codefol.io/posts/10"
---
I'm picking up <a href="http://github.com/maccman/juggernaut">Juggernaut</a> after a long hiatus and seeing it with new eyes, which is fun.

I'm realizing my old <a href="http://github.com/noahgibbs/RailsGame">RailsGame</a> architecture was horrifically overcomplicated.  The rest of you probably knew this a long time ago.

I'm also realizing that Juggernaut has some problems in a <a href="http://en.wikipedia.org/wiki/High_availability">High Availability</a> setting, but that's a topic for a later post.

Juggernaut is interesting because I can now see a lot more of the seams where it's clearly a fun test project, not a "real" project, and I can see how to fix some of them.

For instance:  a JavaScript client can send "events", separate from normal messages, and there's a custom event built in, but there are no accessors to send one.  It's just kind of hanging on there, even though that would be ridiculously useful in some cases.  Functionality's there, documentation and convenience aren't.

And you can subscribe to see messages on channels from non-JavaScript clients, but only by subscribing directly to Redis - you can't ask the server to send non-JavaScript clients things on a given channel.  That's adequate for my needs, but sucks in a lot of other cases.

Basically, Juggernaut thinks of itself as server-push stuff, no full-on pub/sub.

Good to know.

Next post I'll be delving very deep into how to hook up Juggernaut in ways it doesn't expect to get around these problems :-)

