LifeWeb::Application.routes.draw do

  root 'life#index'

  resources :life

end
