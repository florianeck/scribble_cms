class ScribblerImage < ActiveRecord::Base
  
  #= Configuration
  has_attached_file :image, :styles => {:default => "300x200"}, :processors => [:cropper]
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
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
    
    
    def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
    end
    
    def crop_image
      self.image.reprocess!
      crop_x = crop_y = crop_w = crop_h = nil
    end
    
    def opt_image_width
      self.opt_size.split("x").first
    end
    
    def opt_image_height
      self.opt_size.split("x").last
    end  
end
