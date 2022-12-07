Rails.application.routes.draw do
  resources :leases
  resources :apartments
  resources :tenants
end
