require "scribble_cms/engine"
require 'scribble_cms/scribbler_controller_plugin'
require 'scribble_cms/scribbler_element_setup'

require 'dragonfly'
require "smart_search"

module ScribbleCms
  mattr_accessor :tiny_mce_css, :tiny_mce_js

  self.tiny_mce_css = "default_tinymce"
  self.tiny_mce_js  = "Alchemy.Tinymce.initAll();"

  def self.js_files
    ['ext/tinymce.min.js', 'scribbler.js']
  end

  def self.css_files
    ['ext/tinymce.skin.css', 'ext/tinymce.content.min.css']
  end

end

ActionController::Base.send(:include, ScribbleCms::ScribblerControllerPlugin)

String.class_eval do

  def replace_scribbler_vars(vars = {})
    r = self
    vars.each do |var_name, var_content|
      r = r.gsub("*#{var_name}*", var_content.to_s)
    end
    return r
  end

end