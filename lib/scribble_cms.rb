

require "scribble_cms/engine"
require 'scribble_cms/scribbler_controller_plugin'  
require 'scribble_cms/scribbler_element_setup'
require 'dragonfly'

ActionController::Base.send(:include, ScribbleCms::ScribblerControllerPlugin)

String.class_eval do
  
  def replace_scribbler_vars(vars = {})
    r = self
    vars.each do |var_name, var_content|
      r = r.gsub("*#{var_name}*", var_content)
    end
    return r  
  end  
  
end  