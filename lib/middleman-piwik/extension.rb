require 'erubis'
require 'uglifier'

module Middleman
  module Piwik
    class PiwikExtension < Extension
      option :piwik_id, nil, 'Piwik site id'
      option :piwik_domain, nil, 'Piwik domain'
      option :piwik_path, '/', 'Piwik location'
      option :disable, false, 'Disable extension'
      option :minify, false, 'Compress the JavaScript code'
      
      def after_configuration
        unless options.piwik_domain
          $stderr.puts 'Piwik: Please specify a piwik domain'
          raise ArgumentError, 'No property piwik domain given' if app.build?
        end

        unless options.piwik_id
          $stderr.puts 'Piwik: Please specify a site ID'
          raise ArgumentError, 'No property ID given' if app.build?
        end
        
        path = '/' + options.piwik_path + '/'
        path.sub!(/^\/*/,'/').sub!(/\/*$/,'/')
        options.piwik_path = path
      end

      helpers do
        def insert_piwik_tracker_img
          options = extensions[:piwik].options
          return nil if options.disable

          content = "\n<p><img src=\"https://#{options.piwik_domain}#{options.piwik_path}piwik.php?idsite=#{options.piwik_id}\" style=\"border:0;\" alt=\"\" /></p>\n"
          content = Uglifier.compile(content) if options.minify
          content_tag(:noscript, content)
        end

        def insert_piwik_tracker_js
          options = extensions[:piwik].options
          return nil if options.disable

          file = File.join(File.dirname(__FILE__), 'piwik.js.erb')
          context = { options: options }
          content = Erubis::FastEruby.new(File.read(file)).evaluate(context)
          content = Uglifier.compile(content) if options.minify
          content_tag(:script, content, type: 'text/javascript')
        end

        def insert_piwik_tracker
          insert_piwik_tracker_js + insert_piwik_tracker_img
        end
      end
    end
  end
end 
