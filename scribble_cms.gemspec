$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "scribble_cms"
  s.version     = "0.5"
  s.authors     = ["Florian Eck"]
  s.email       = ["it-support@friends-systems.de"]
  s.homepage    = "http://www.friends-systems.de"
  s.summary     = "Easy-to-use tool for placing user-editable content in your pages"
  s.description = "Easy-to-use tool for placing user-editable content in your pages"

  s.files = Dir["{app,config,db,lib}/**/*"]

  s.add_runtime_dependency 'friendly_extensions', '>= 0.0.66'
  s.add_runtime_dependency 'friends_ajax_core'
  s.add_runtime_dependency 'paperclip', '>= 2.1.0'
end
