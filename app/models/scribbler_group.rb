class ScribblerGroup < ActiveRecord::Base

  #= Configuration
      #== Associations
      belongs_to :container, :class_name => "ScribblerContainer", :foreign_key => "container_id", :touch => true 
     
      has_many :texts, :class_name => "ScribblerText", :foreign_key => "group_id"
      #== Plugins and modules
        #=== PlugIns
          # => Stuff in Here        
  
        #=== include Modules
          # => Stuff in Here
  
      #== Konstanten
      ELEMENTS = {:row => ScribblerText, 
                  :text => ScribblerText,
                  :link => ScribblerLink,
                  :image => ScribblerImage,
                  :var => ScribblerVar}
  
      #== Validation and Callbacks
        #=== Validation
        validates_uniqueness_of :name, :scope => :container_id
          
        #=== Callbacks
        after_destroy :destroy_elements
         
    # => END
    
    # Display data
    def row(row_name, options = {})
      e = get_element(:row, row_name)
      if e.content.blank? && options[:default]
        e.update_attributes(:content => options[:default])
      end
      return e.content.to_s.html_safe
    end
    
    def text(text_name, options = {})
      e = get_element(:text, text_name)
      if e.content.blank? && options[:default]
        e.update_attributes(:content => options[:default])
      end
      return e.content.html_safe
    end  
    
    def link(link_name, options = {})
      link = get_element(:link, link_name)
      options.merge!(:target => "_blank") if link.external
      ActionController::Base.helpers.link_to(link.title, link.url, options)
    end
    
    def image(image_name, options = {})
      e = get_element(:image, image_name, options)
      if e.image
        e.image.url
      else
        ""
      end    
    end
    
    def var(name, options = {})
      get_element :var, name
    end  
    
    
    
    # Helpers
    def get_element(type, name, options = {:released => true})
      options[:released] ||= true

      case type
      when :row
        options.merge!(:plain => true)
      when :text
        options.merge!(:plain => false)
      when :link
        # ...
      when :image
          
      end    
      
      options.merge!(:name => name, :group_id => self.id)
      
      element_class = ELEMENTS[type]
      
      element = element_class.where(options).first
      if element.nil?
        element_class.create(options.merge(:released => !options[:released]))
        element = element_class.create(options)
      end
      
      
      return element 
    end  
    
    def elements(options = {:released => true})
      ELEMENTS.values.uniq.map {|c| c.where(:group_id => self.id, :released => options[:released] == true)}.flatten.sort_by {|e| e.name}
    end
    
    def released_elements
      self.elements(:released => true)
    end
    
    def unreleased_elements
      self.elements(:released => false)
    end    
    
    def destroy_elements
      self.elements.each {|e| e.destroy }
    end  
    
    # Save data
    def process_group_data(data = {})
      # Update realesed data
      self.process_data!(data[:released])
      
      # Update unrealesed data
      self.process_data!(data[:unreleased]) if data[:unreleased]
    end 
    
    def process_data!(data)
      data.each do |key, content|
        e_id    = content.delete(:id)
        e_type  = content.delete(:type)
        e_rel   = content.delete(:release)
        element = ELEMENTS[e_type.to_sym].find(e_id)
        element.update_attributes(content)
        
        if e_rel == "1"
          element.release!
        end  
      end  
    end
    
    def human_name
      I18n.t(self.name, :scope => "scribbler.group_names", :default => self.name.humanize)
    end  
    
    
       
    
end
