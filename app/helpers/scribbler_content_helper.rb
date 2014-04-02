module ScribblerContentHelper
  
  def scribbler_container(container_name, options = {}, &block)
    container_name = "#{container_name}-#{options[:element].page.name}-#{options[:element].id}" if options[:element]
    q = {:name => container_name, :scaleable => (options[:scaleable].nil? ? false : options[:scaleable]), :element_id => (options[:element] ? options[:element].id : nil)}
    container = ScribblerContainer.where(:name => container_name).first || ScribblerContainer.create(q)
    container.update_attributes(:scaleable => options[:scaleable]) if options[:scaleable] && container.scaleable != options[:scaleable]
    capture(container, &block)
  end
  
  def scribbler_group(container, group, &block)
    scribbler_container(container) do |c|
      c.scribbler_group(group) do |g|
        capture(g, &block)
      end  
    end  
  end
  
  def scribbler_element(container, group, type, name)
    scribbler_group(container, group) do |g|
      g.send(type, name)
    end
  end  
  
  # Form
  def scribbler_form_element(element,form)
    render :partial => "/scribbler_content/forms/#{element.element_type}", :locals => {:element => element, :f => form} 
  end    
  
  
  def scribbler_layout(&block)
    render :partial => "/scribbler_admin/scribbler_layout", :locals => {:content => capture(&block)}
  end  
  
end  