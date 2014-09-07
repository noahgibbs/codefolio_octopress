---
layout: post
title: "Should You Stop Being Bob?"
date: 2014-09-01 17:11
comments: true
categories: 
---
Want to build a <a href="http://ngauthier.com/2013/02/rails-4-sse-notify-listen.html">realtime web game</a>? Or a web site that <a href="http://tenderlovemaking.com/2012/07/30/is-it-live.html">updates instantly when users add stuff</a>?


You're going to need to take control of your own deployment. Heroku, for instance, <a href="http://codefol.io/posts/when-should-you-not-use-heroku" target="_blank">isn't going to handle that well</a>.

But first, here's a little parable about Bob (who is, um, totally <b>not an alias for my early mistakes</b>... Probably.)

{% img "img-responsive" /images/Yellow_Submarine_Second_Life.png 562 300 A Yellow Submarine %}

## The Parable About Bob

Bob was an old-time C programmer. When he built C programs in his spare time, nobody ever saw them. <a href="http://www.shamusyoung.com/twentysidedtale/?p=9557">You can give people source code, but usually they can't use it</a> in that world. And building an installer is horrible, especially if you have any friends with a different OS than you use. That used to happen, back in the day.

Ruby on Rails was awesome and Bob loved it. You could put something on a server and then your friends could use it. How cool is that?

<!--more-->

And it had some fun new features like server-sent events. If you can make a good chat server, <a href="http://noahgibbs.github.io/RailsGame/architecture.html">chances are good you can make a game</a>, too. Bob was trying that out.

And actually, he came up with a kind of cool game. There were some hexes and some things in them. Stuff moved around a little and there was a chat window next to it.

{% img /images/hexes.png A map divided into hexes %}

Bob was running everything on his development machine, which was <a href="https://github.com/maccman/juggernaut#running" target="_blank">a little complicated</a>, but he
could manage.

Bob had a server that he used for a few things, and mostly he just <a href="http://martinfowler.com/bliki/SnowflakeServer.html" target="_blank">installed stuff by hand</a>.

So he went ahead and ran everything he needed (back then: Redis, an even older version of Juggernaut and his Rails app.) And everything was fine.

Of course, he had to set everything up again when he rebooted. But that wasn't a big deal.

Also, his app would crash sometimes. That wasn't a huge thing.

{% img right /images/unhappy_toadstool.jpeg An unhappy toadstool, frowning. %}
Juggernaut would also crash sometimes, and that meant restarting it <b>and</b> his Rails app.

And every time somebody logged in, something wasn't working. Sometimes they emailed Bob. Mostly, they just didn't look at the game, even though it was kinda cool.

Before long, Bob didn't feel like showing off his game to his friends any more.

In fact, he was kinda done building games. Suddenly, Ruby on Rails kind of sucked.

## Maybe Don't Be Bob?

Bob didn't know it, but a lot of his problem was that deploying Rails apps suddenly gets hard when you care about the details. Anything you'd build an interactive game or a chat server on turns out to require some work. You need to care about what app server you use (Unicorn? Thin?) You need to care about running custom servers (<a href="http://redis.io" target="_blank">Redis</a>? Something with <a href="http://rubyeventmachine.com" target="_blank">EventMachine</a>?)

Unfortunately, that's harder than it should be. Right now, <a href="http://heroku.com" target="_blank">off-the-rack solutions</a> don't usually work.

Right now, you need to use a big custom stack of tools, and they're hard to use.

You could go read up on <a href="http://getchef.com" target="_blank">all</a> <a href="http://capistranorb.com" target="_blank">the</a> <a href="http://vagrantup.com">tools</a> and debug them together.

Or you could let me do it.

Sadly, I know all about Bob. And it sucks to be him.

Instead, <a href="http://rubymadscience.com">let me show you how to set up your deploy the right way</a> -- that means easy to modify, easy to re-roll-out, easy to run custom stuff.

My pilot program is open right now.

<a href="http://rubymadscience.com">Want to stop being Bob?</a>
