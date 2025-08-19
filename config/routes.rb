Rails.application.routes.draw do
  devise_for :authors
  get "up" => "rails/health#show", as: :rails_health_check
  # root to: proc { [200, {}, ['Hello world']] }


  get    "/authors",          to: "authors#index",   as: "authors"
  get    "/authors/new",      to: "authors#new",     as: "new_author"
  post   "/authors",          to: "authors#create"
  get    "/authors/:id",      to: "authors#show",    as: "author"
  get    "/authors/:id/edit", to: "authors#edit",    as: "edit_author"
  patch  "/authors/:id",      to: "authors#update"
  put    "/authors/:id",      to: "authors#update"
  delete "/authors/:id",      to: "authors#destroy"
  get "/about-authors", to: "authors#about", as: "about_authors"
 
get '/all_books', to: 'books#all_books'

  root to: "books#index"

  resources :books

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end


end
