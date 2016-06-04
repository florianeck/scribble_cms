module ScribbleCms
  module ScribblerControllerPlugin

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def scribbler_cms_controller(options = {})

        self.send(:include, InstanceMethods)
        self.send :before_filter, :get_container, :only => %w(container_edit container_update container_add_item)
        self.send :before_filter, :get_group, :only => %w(group_edit group_update group_destroy)
        self.cattr_accessor :hide_scribbler_edit_status

        self.hide_scribbler_edit_status = (options[:hide_scribbler_edit_status] == true)
      end

    end


    module InstanceMethods




      def index
        @containers = ScribblerContainer.all
        render "/scribbler_admin/index"
      end

      # Containers
      def container_edit
        render "/scribbler_admin/container_edit"
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

      def search
        @containers = ScribblerContainer.all
        @items = ScribblerText.find_by_tags(params[:scribbler][:query])
         render "/scribbler_admin/search"
      end


      # Groups
      def group_edit
        @containers = ScribblerContainer.all
        render "/scribbler_admin/group_edit"
      end

      def group_update
        @group.process_group_data(params[:scribbler_group].to_hash)
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


      def picture

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

  end
end