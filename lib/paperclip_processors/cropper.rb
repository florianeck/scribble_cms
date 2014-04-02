module Paperclip
  class Cropper < Thumbnail
    def transformation_command
      if crop_command
        crop_command
      else
        super
      end
    end
    
    def crop_command
      target = @attachment.instance
      puts "try Croppper"
      if target.cropping?
        puts "cropper!"
        cmd = [" -crop '#{target.crop_w.to_i}x#{target.crop_h.to_i}+#{target.crop_x.to_i}+#{target.crop_y.to_i}'"]
        cmd << "-auto-orient"
        cmd << "-resize #{target.opt_image_width}x#{target.opt_image_height}"
      end
    end
  end
end

