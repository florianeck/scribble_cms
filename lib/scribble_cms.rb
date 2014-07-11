

require "scribble_cms/engine"
require 'scribble_cms/scribbler_controller_plugin'  
require 'scribble_cms/scribbler_element_setup'
require 'dragonfly'

ActionController::Base.send(:include, ScribbleCms::ScribblerControllerPlugin)