middleman-static-d3
===================

A middleman template that allows the creation of self-contained static d3 visualization. No web server required!

I was looking for an easy way to use D3.js to produce static self-contained HTML files.  Ordinarily, d3.js has several dependencies that prevent it from running off the filesystem -- you usually need a webserver.

However, there are times when you want to compile a D3.js visualization without requiring a webserver.

#How it works

This template provides some helpers that basically take your middleman file dependencies and render them as data-uris, in-page.  This means you can use js, css, json files without having to worry about deploying your d3 vis.

The end result of a build is a completely portable static html file (no extra css, js, or other data files).

# Try it!

You should have the following prerequisites:

* ruby 2.1.2
* git
* modern brower that supports d3.js
* (optional) rvm

Quickstart with the sample viz included in the template:

    $ git clone https://github.com/coldnebo/middleman-static-d3.git my_d3_vis
    $ cd my_d3_vis
    $ bundle install
    $ middleman build
          create  build/index.html
    $ google-chrome build/index.html

# Template details

Let's take a look at the template in more detail:

    .
    ├── config.rb
    ├── Gemfile
    ├── Gemfile.lock
    ├── lib
    │   └── static_d3_helpers.rb
    ├── README.md
    └── source
        ├── data                 # d3 data folder (not to be confused with middleman ./data!)
        │   └── data.tsv         # example TSV data file
        ├── images
        │   └── middleman.png
        ├── index.html.erb       # example d3.js viz
        ├── javascripts
        │   ├── d3.js
        │   ├── d3.min.js        # included d3.js version
        │   └── LICENSE
        ├── layouts
        │   └── layout.erb
        └── stylesheets
            └── normalize.css


Next, it's time to make your own.

* take a look at `source/index.html.erb` to see how the file format works.

Normalize.css and d3.js are automatically included for you (see `source/layouts/layout.erb` for how). You can embed your own js and css files with the embedding helpers below.




#Helpers

Adds the following helpers:

* javascript_embed(js_path)
* stylesheet_embed(css_path)
* data_embed(data_path, var_name) - used to embed files under data
* data_uri(source_path, mime_type) - used to create a data_uri for image tags, etc.
* inline(data) - used to fit data on a single line for embedding into js.



