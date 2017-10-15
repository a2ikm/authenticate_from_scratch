Rails.application.routes.draw do
  root "root#index"
  resource :login, only: %i(new create)
end
