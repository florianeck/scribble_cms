class ScribblerPicturesController < ApplicationController
  
  def show
    img = ScribblerImage.find_by_image_name("#{params[:name]}.#{params[:format]}")  
    
    if img
      begin
          send_file(img.image.path,  :disposition => 'inline', :status => 200)
      rescue Dragonfly::Job::Fetch::NotFound
        render :text => nil, :status => 404  
      end
    else
      render :text => nil 
    end    
    
  end  
  
end  