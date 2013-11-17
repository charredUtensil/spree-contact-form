Spree::Core::Engine.add_routes do
  resource :contact, :controller => 'contact'

  namespace :admin do 
    resources :contact_topics
  end	
end
