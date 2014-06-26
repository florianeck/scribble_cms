class ScribblerVar < ActiveRecord::Base
  
  #= Configuration
      #== Associations
      
      
      #== Plugins and modules
        #=== PlugIns
          # => Stuff in Here        
  
        #=== include Modules
        include ScribbleCms::ScribblerElementSetup
  
      #== Konstanten
      VAR_TYPES = {
        :decimal => ""
      }
  
      #== Validation and Callbacks
        #=== Validation
       
          
        #=== Callbacks
          # => Stuff in Here
          
          
    # => END
    
    
    def self.get(container_name, group_name, name, type)
      
      q = {:name => container_name}
      container = ScribblerContainer.where(:name => container_name).first || ScribblerContainer.create(q)
      container.scribbler_group(group_name) do |g|
        return g.var(name, type)
      end  
      
      
    end
    
    def self.set(group, name, value)
    end    
  
end  