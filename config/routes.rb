Scribbler::Engine.routes.draw do
  
  get "/s/static/pictures/:job/:name.:format" => "scribbler_pictures#show"
  
  
end  