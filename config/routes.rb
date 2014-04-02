Scribbler::Engine.routes.draw do
  
  %w( container_edit container_add_item group_edit group_destroy image_cropper).each do |a|
    get "/scribbler_admin/#{a}/(:id)", :controller => "scribbler_admin", :action => a
  end  
  
  get "/scribbler_admin", :controller => "scribbler_admin", :action => "index", :as => :scribbler_admin
  
  %w(container_update group_update crop_image).each do |a|
    post "/scribbler_admin/#{a}/(:id)", :controller => "scribbler_admin", :action => a
  end  
  
  
  
end  