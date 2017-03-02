# Middleman-Piwik

`middleman-piwik` is an extension for the [Middleman](http://middlemanapp.com/) static site generator that ease the use of the [Piwik](http://piwik.org/) web analytics platform.

## Installation

Just add `gem "middleman-piwik"` to your existing Gemfile and run `bundle install`.

## Configuration

```ruby
activate :piwik do |p|
    p.piwik_id = 1
    p.piwik_domain = 'piwik.example.net'
    p.piwik_path = '/piwik'
    p.disable = false
    p.minify = false
end
``` 

piwik_id is the id of the site, as given by piwik. Usually, it start at 1.

piwik_domain is the domain name of the piwik server. 

piwik_path is the path of the piwik installation. By default, it take the root of the website.

disable - disable extension (default = false)

minify - compress the JavaScript code (default = false)

## Helper

The extension adds 3 new helper to Middleman to add the proper javascript and img in your website

```erb
<%= insert_piwik_tracker %>
```

The one that should be almost always be used is `insert_piwik_tracker`, which will try to insert the regular javascript code and a img tag as a fallback.

The 2 others `insert_piwik_tracker_js` and `insert_piwik_tracker_img` will add only the javascript tracker or the img one.

## Note !!!

Compatible with Middleman 4