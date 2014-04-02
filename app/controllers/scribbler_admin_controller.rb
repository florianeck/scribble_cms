class ScribblerAdminController < ApplicationController
  
  before_filter :get_container, :only => %w(container_edit container_update container_add_item )
  before_filter :get_group, :only => %w(group_edit group_update group_destroy)
    
    
  def index
    @containers = ScribblerContainer.all
  end
  
  # Containers
  def container_edit
  end
  
  def container_update
    @container.update_attributes(container_params)
    flash[:notice] = "Container #{@container.name} was saved"
    redirect_to :action => "index"
  end
  
  def container_add_item
    @container.get_group("#{@container.id}-#{Time.now.to_i}")
    flash[:notice] = "Neues Element für #{@container.name} wurde angelegt"
    redirect_to :back
  end  
  
  
  
  
  # Groups
  def group_edit
    render :layout => false
  end
  
  def group_update
    @group.process_group_data(params[:scribbler_group])
    flash[:notice] = "Änderungen wurden gespeichert"
    redirect_to :back
  end
  
  def group_destroy
    @group.destroy
    flash[:notice] = "Daten wurden gelöscht"
    redirect_to :action => "index"
  end    
  
  # images
  def image_cropper
    @element = ScribblerImage.find(params[:id])
  end
  
  def crop_image
    @element = ScribblerImage.find(params[:id])
    @element.update_attributes(image_params)
    @element.image.reprocess!
    redirect_to :action => "group_edit", :id => @element.group_id
  end    
  
  # Private - permit parameters
  private
  
  def get_container
    @container = ScribblerContainer.find(params[:id])
  end
  
  def get_group
    @group = ScribblerGroup.find(params[:id])
  end  
  
  def container_params
    params.require(:scribbler_container).permit(:description)
  end
  
  def image_params
    params.require(:scribbler_image).permit(:crop_x, :crop_y, :crop_w, :crop_h)
  end
end
