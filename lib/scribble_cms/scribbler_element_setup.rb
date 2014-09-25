module ScribbleCms
  module ScribblerElementSetup
    
    def self.included(base)
      base.send(:belongs_to, :group, :class_name => "ScribblerGroup", :foreign_key => "group_id", :touch => true)
      base.send(:validates_presence_of, :group_id)
      base.send(:before_save, :check_uniqueness)
    end
    
    
    def check_uniqueness
      items = self.class.where(:name => self.name, :group_id => self.group_id, :released => self.released)
      items.empty? || items.size == 1
    end 
    
    def element_type
      if self.is_a?(ScribblerLink)
        return :link
      elsif self.is_a?(ScribblerText) && self.plain
        return :row
      elsif self.is_a?(ScribblerText) && !self.plain   
        return :text
      elsif self.is_a?(ScribblerImage)  
        return :image
      elsif self.is_a?(ScribblerVar)
        return :var  
      end  
    end
    
    def human_name
      I18n.t(self.name, :scope => "scribbler.element_names.#{self.group.name}")
    end     
    
    def hint  
      h = I18n.t(self.name, :scope => "scribbler.element_hints.#{self.group.name}", :default => "")
      h.is_a?(Array) ? h.join("") : h
    end  
    
  end
end  