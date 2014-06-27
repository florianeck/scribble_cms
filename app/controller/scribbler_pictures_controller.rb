class ScribblerPicturesController < ApplicationController
  
  def show
    img = ScribblerImage.find_by_image_name("#{params[:name]}.#{params[:format]}")  
    
    if img
      send_file(img.image.path,  :disposition => 'inline', :status => 200)
    else
      render :text => nil 
    end    
    
  end  
  
end  