class ScribblerLink < ActiveRecord::Base
  
  #= Configuration
      #== Associations
      
      
      #== Plugins and modules
        #=== PlugIns
          # => Stuff in Here        
  
        #=== include Modules
        include ScribbleCms::ScribblerElementSetup
  
      #== Konstanten
          # => Stuff in Here
  
      #== Validation and Callbacks
        #=== Validation
        
          
        #=== Callbacks
          # => Stuff in Here
          
          
    # => END
    
    def url
      self[:url].blank? ? "/" : self[:url]
    end  
  
end
