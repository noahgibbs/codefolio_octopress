---
layout: post
title: "What's Deployment versus Provisioning versus Orchestration?"
date: 2015-04-13 16:38
comments: true
categories:
signup: deploy
---
Hey, Ruby web developers! Having trouble asking deployment questions?
Not sure what Provisioning or Orchestration are? Getting bad results
Googling your questions, but not sure why?

Let's go over some deployment vocabulary from your point of view
&mdash; that makes it a lot easier to Google and to read information
about deploying your app to a server, and setting up that server in
the first place.

As a nice side effect, you may have an easier time talking to your Ops guy at work.

First, let's go over what the word "deployment" means:

## Deployment

<b>&lsquo;Deployment&rsquo;</b> is the process of putting a new application, or new
version of an application, onto a prepared application server.

If you are talking to a developer, it may also mean the process of
preparing the server, perhaps by installing libraries or daemons.
<b>If you are talking to an operations professional, it DOES NOT.</b>
They use the word "provisioning" for that.

(Developers are going to keep using the word "deploy" for everything
involved in getting our app and its dependencies installed. That's
cool. But don't be surprised if you confuse your Ops guy.)
<!--more-->

Ruby developers often use <a href="http://capistranorb.com/">Capistrano</a> or <a href="http://nadarei.co/mina/">Mina</a> for deployment.

## Provisioning

The word &lsquo;<a
href="http://en.wikipedia.org/wiki/Provisioning">Provisioning</a>&rsquo;
is normally used by Ops folks to refer to getting computers or virtual
hosts to use, and installing needed libraries or services on
them. They use the word for a lot of other things as well, such as
buying access to network bandwidth, but you can probably ignore that.

The thing to remember is that &lsquo;deployment&rsquo; does not, as a
rule, include &lsquo;provisioning&rsquo;.

Ruby developers often use <a href="http://getchef.io">Chef</a>, <a
href="http://ansible.com">Ansible</a> or <a
href="http://puppetlabs.com">Puppet</a> for server provisioning. This
can also be done automatically by a service like <a
href="http://engineyard.com">Engine Yard</a>, <a
href="http://heroku.com">Heroku</a> or <a
href="http://ninefold.com">NineFold</a>.

## Orchestration

Now we're getting a little less common.

<a
href="http://en.wikipedia.org/wiki/Orchestration_(computing)">Orchestration</a>
means arranging or coordinating multiple systems. It's also used to
mean "running the same tasks on a bunch of servers at once, but not
necessarily all of them."

Normal uses are things like:

* Run the latest migration on all your database servers, but not all your Rails app servers
* On each Rails server, check the current Ruby patchlevel and send it back
* Check "ps" and make sure that Daemontools is still running on every server, everywhere
* Find any Node.js processes and terminate with extreme prejudice ;-)

The most common orchestration tool for Ruby programmers is Capistrano, followed by Mina.

Orchestration tools include <a
href="http://www.fabfile.org/">Fabric</a>, <a
href="https://puppetlabs.com/mcollective">MCollective</a>, <a
href="http://saltstack.com/">Salt</a> and many more. It's pretty
common for your Orchestration tool to also be a provisioning tool
(Salt, arguably Ansible) or an app deploy tool (Capistrano, Mina), or
potentially something else as well.

Of course, that's only if you don't count SSH, the most common
orchestration tool of all :-)
