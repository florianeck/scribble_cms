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

    if defined?(ActiveAdmin)
      initializer 'activeadmin.tinymce', :group => :all do |app|
        js = ['ext/tinymce.min.js', 'scribbler.js', 'ext/themes/modern/theme.min.js']
        css = ['ext/skins/lightgray/skin.min.css', 'ext/skins/lightgray/content.min.css']

        app.config.assets.precompile += js
        app.config.assets.precompile += css

        ActiveAdmin.application.tap do |config|
          js.each do |j|
            config.register_javascript j
          end

          css.each do |s|
            config.register_stylesheet s
          end
        end
      end
    end

  end
end

