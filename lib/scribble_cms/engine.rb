module Scribbler
  class Engine < Rails::Engine



    engine_name 'scribbler'

    initializer "dragonfly.scribbler" do

      # Pictures
      Dragonfly.app(:scribbler).configure do
        plugin :imagemagick
        datastore :file, root_path:  Rails.root.join('public/system/uploads/scribbler').to_s, store_meta: false
        url_format "/s/static/pictures/:job/:name.:format"
        secret Digest::SHA1.hexdigest(Rails.root.to_s)
      end
    end


    initializer 'activeadmin.tinymce', :group => :all do |app|

      app.config.assets.precompile += ScribbleCms.js_files
      app.config.assets.precompile += ScribbleCms.css_files

      if defined?(ActiveAdmin)
        ActiveAdmin.application.tap do |config|
          ScribbleCms.js_files.each do |j|
            config.register_javascript j
          end

          ScribbleCms.css_files.each do |s|
            config.register_stylesheet s
          end
        end
      end
    end

  end
end

