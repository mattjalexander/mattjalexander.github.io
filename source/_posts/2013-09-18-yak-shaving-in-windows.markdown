---
layout: post
title: "yak shaving in windows"
date: 2013-09-18 21:51
comments: false
categories: [yak-shaving,rant]
---

{% img right images/debian.jpg 213 160 %}

The Pain
========

Given my work environment, I had totally forgotten the utter pain of attempting
to develop under Windows. THE HORROR. Sure, I've got Virtualbox, and sure, I've
got Vagrant. But hey, good luck running any useful vagrant commands with
`cmd.exe`, a shell with all of the latest technologies from 1803. Add in janky
graphics cards support from debian, opscode only providing chef servers for
Ubuntu(!) and RHEL, and I'm back staring at a series of �s because I've lost whatever juju
was between Windows, puTTY, and bash.

And let's not even get into bouncing from Apple's shortcuts, windows', and
puttys, in under 8 hours. I basically just mash right click, middle, click,
CMD+V, and CTRL+V until something pastes.

Part of all this pain is, I think, why I've been drawn to systems
administration and automation engineering -- this friction of doing anything **useful** is as pointless
and tasteless as apps involving staring at mammary glands.

The Joy
=======

On the plus side, importing [putty.reg](https://raw.github.com/mattjalexander/dotfiles/master/manual/putty.reg) totally worked. This is a blinking, fluorescent light in the path; one day, I'll be done screwing with this uselessness.

The Way Forward
===============

- I've already ordered a larger SSD, fixing the mistake of being cheap, so I
  should be able to just run a Virtualbox of a Real OS. Which apparently means
  Ubuntu since Debian graphics continually whack out. And no, I'm not installing
  cygwin, that's just insane. The hilarity here, of course, is that my workflow
  will inevitably mean running virtual machines inside of virtual machines, and
  sometimes VMs inside of VMs inside of VMs. THE JOYS OF TESTING SYSTEMS AS A
  WHOLE.

- I'll need to install a Chef/Puppet/Ansible/something for my local network.
  Chef is the obvious choice since that's what $CURRENT_WORK is into. Sadly, of
  my physical machines, the only "proper" server is debian in i686, which
  totally isn't provided by opscode. So, uh, either Enterprise chef or a chef
  server inside a vm. Either is good enough for a toy home network.

PS
==

I'm still amazed that aspell is still the state-of-the-art for commandline spell
checking. vim and aspell will outlast all of us.
