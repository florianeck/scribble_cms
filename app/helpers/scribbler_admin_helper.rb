module ScribblerAdminHelper
  
  # Form
  def scribbler_form_element(element,form)
    render :partial => "/scribbler_content/forms/#{element.element_type}", :locals => {:element => element, :f => form} 
  end    
  
  
  def scribbler_layout(&block)
    render :partial => "/scribbler_admin/scribbler_layout", :locals => {:content => capture(&block)}
  end 
  
end
