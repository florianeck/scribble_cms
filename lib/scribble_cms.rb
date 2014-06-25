

require "scribble_cms/engine"
require 'scribble_cms/scribbler_controller_plugin'  
require 'scribble_cms/scribbler_element_setup'

ActionController::Base.send(:include, ScribbleCms::ScribblerControllerPlugin)