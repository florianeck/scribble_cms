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

  end
end

