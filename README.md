middleman-static-d3
===================

A middleman template that allows the creation of self-contained static d3 visualization. No web server required!

I was looking for an easy way to use D3.js to produce static self-contained HTML files.  Ordinarily, d3.js has several dependencies that prevent it from running off the filesystem -- you usually need a webserver.

However, there are times when you want to compile a D3.js visualization without requiring a webserver.

#How it works

This template provides some helpers that basically take your middleman file dependencies and render them as data-uris, in-page.  This means you can use js, css, json files without having to worry about deploying your d3 vis.

The end result of a build is a completely portable static html file (no extra css, js, or other data files).

# Try it!

First, get the template:

    $ git clone https://github.com/coldnebo/middleman-static-d3.git my_d3_vis
    $ cd my_d3_vis
    $ middleman build
          create  build/index.html


#Helpers

Adds the following helpers:

* javascript_embed(js_path)
* stylesheet_embed(css_path)
* data_embed(data_path, var_name)

