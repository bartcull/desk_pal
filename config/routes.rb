DeskPal::Application.routes.draw do
  patch 'update_label' => 'cases#update_label'
  resources :labels
  resources :cases
  root 'cases#index'
end
