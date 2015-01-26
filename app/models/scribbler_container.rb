class ScribblerContainer < ActiveRecord::Base
  
  #= Configuration
      #== Associations
      has_many :groups, :class_name => "::ScribblerGroup", :foreign_key => "container_id"
       belongs_to :element, :class_name => "Alchemy::Element", :foreign_key => "element_id"
      #== Plugins and modules
        #=== PlugIns
          # => Stuff in Here        
  
        #=== include Modules
          # => Stuff in Here
  
      #== Konstanten
          # => Stuff in Here
  
      #== Validation and Callbacks
        #=== Validation
        validates_uniqueness_of :name, :on => :create, :message => "must be unique"
          
        #=== Callbacks
        before_create { self.description = self.name }
          
          
    # => END
    
  def scribbler_group(name, &block)
    yield(self.get_group(name))
  end
  
  def get_group(name)
    ScribblerGroup.where(:name => name, :container_id => self.id).first || ScribblerGroup.create(:name => name, :container_id => self.id)
  end  
  
  def description
    I18n.t(self.name, :scope => "scribbler.container_names", :default => self.name.humanize)
  end  
  
    
  
end
