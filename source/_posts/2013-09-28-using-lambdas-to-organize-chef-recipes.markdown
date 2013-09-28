---
layout: post
title: "Using lambdas to organize Chef recipes"
date: 2013-09-28 14:06
comments: false
categories:
- chef
- devops
---

Let's explore for a moment, that you support an in-house app -- let's call it **dingus**.

So you, like any good Chef user, set out to make a chef recipe, let's call it **chef-dingus** (or maybe you like **dingus-cookbook** instead?).
Let's start piecing this together.

To put together **dingus-cookbook**, you're going to need

+ configure a dingus user, various directories and config files, and permission them properly. Depending on dingus, this may mean an entire suite of logic inside your recipe and inside templates.
+ Perhaps [Apparmor](https://github.com/opscode-cookbooks/apparmor) is getting in your way, so let's include that recipe
+ Add an [Apache2](https://github.com/opscode-cookbooks/apache2) frontend
+ Turns out you need [rvm](https://github.com/fnichol/chef-rvm) too, so you put that in there.
+ ...
+ You know better than I do what you company's **dingus** needs to be properly deployed.


Twelve layers down the stack, you see where this is going. Your recipe is perhaps several hundreds lines long and you're having difficulty keeping track of ordering, particularly when you need to insert new logic (Hey, we want to deploy **dingus** onto RHEL in addition to Ubuntu, so now we have to properly configure SELinux!). Some of this is abstracted away, in say, attributes/defaults.rb or perhaps even a stack of **company-basenode** cookbooks.

But that's not enough; you're still left with a recipe that's quite large and manages a single **dingus**. So how can we make this readable?
Easy: **lambdas**.  Simply encase each step in a lambda, as so:

{% codeblock lang:ruby Defining your lambdas %}
disable_apparmor = lambda do
  include_recipe 'apparmor'
done

configure_dingus_user = lambda do
  user dingus do
    action create
  done
done

configure_custom = lambda do
  ...
done

configure_apache2 = lambda do
  include_recipe 'apache2'
  include_recipe 'apache2:mod_ssl'
  include_recipe 'apache2:php5'
done

compile_time_essentials = lambda do
  include_recipe 'apt'
  include_recipe 'build-essentials'
  chef_gem 'mongodb'
done

{% endcodeblock %}

So far, your recipe has done nothing at convergence, only parsed. At the end of your, just call the lambdas.

{% codeblock lang:ruby λ %}
compile_time_essentials.call
disable_apparmor.call
configure_dingus_user.call
configure_apache2.call
configure_custom.call
{% endcodeblock %}

What does organizing your recipe in this way net you? Several things, any one of which is powerful.

1. You can trivially re order your recipe by focusing on the lambda calls. Simply being able to visualize the logical steps that the recipe is taking can help vastly.(*)
1. (1.5) You can also trivially comment out lambdas if they're causing you trouble.
2. It makes this giant **dingus-cookbook** easier to parse by breaking it into logical sub components. Perhaps along the way, your company starts making **widgets** in additions to **dinguses**, and so you pull out the apache2 lambda into it's own **company-cookbook**. Perhaps not.
3. Since they're lambdas, you don't need to worry about scope. They exist within the recipe, and that's it.
4. In addition, this helps you ensure code coverage and test sanity as your tests are now things like
`test_compile_time_essentials` and `test_apache2` instead of choosing semi-random files to check permissions on.

# Happy cooking!

(*) Do be aware of compile-time actions versus convergence actions with chef recipes. Simply because your code is at the top may not necessarily mean it occurs before another event. See [About the chef-client Run](http://docs.opscode.com/essentials_nodes_chef_run.html) for more information.
