class ScribblerImage < ActiveRecord::Base

  #= Configuration
  dragonfly_accessor :image, app: :scribbler do
    after_assign{|i| i.name = sanitize_filename(image.name) }
  end


  def sanitize_filename(filename)
    [filename.split(".").first.parameterize, filename.split(".").last].join(".")
  end

  #validates_presence_of :image
  validates_size_of :image, maximum: 2.megabytes
  validates_property :format,
    of: :image,
    in: [:gif, :png, :jpg, :jpeg],
    case_sensitive: false,
    message: I18n.t("not a valid image")



      #== Associations

      #== Plugins and modules
        #=== PlugIns
          # => Stuff in Here        #

        #=== include Modules
        include ScribbleCms::ScribblerElementSetup

      #== Konstanten
          # => Stuff in Here

      #== Validation and Callbacks
        #=== Validation


        #=== Callbacks
#        after_update :crop_image, :if => :cropping?


    # => END



end
