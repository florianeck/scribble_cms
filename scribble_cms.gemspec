$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "scribble_cms"
  s.version     = "0.8"
  s.authors     = ["Florian Eck"]
  s.email       = ["florian.eck@el-digital.de"]
  s.homepage    = "http://www.el-digital.de"
  s.summary     = "Easy-to-use tool for placing user-editable content in your pages"
  s.description = "Easy-to-use tool for placing user-editable content in your pages"

  s.files = Dir["{app,config,db,lib}/**/*"]

  s.add_dependency 'friendly_extensions', '~> 0.2.4'
  s.add_runtime_dependency 'dragonfly'
  s.add_dependency 'smart_search', '~> 0.0.79'
end
