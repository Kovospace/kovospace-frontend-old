Rails.application.routes.draw do
  
  ### set up homepage
  root to: 'homepage#index'

  get 'home',
    to: "homepage#index",
    as: "home"

  get 'blog',
    to: "blogs#index",
    as: "blogs"



  ### articles page

  get '/post',
    to: "posts#index",
    as: "posts"

  get '/post/new',
    to: "posts#new",
    as: "new_post"

  post '/post',
    to: "posts#create"

  get '/post/:id/edit',
    to: "posts#edit",
    as: "edit_post"

  patch '/post/:id/update',
    to: "posts#update",
    as: "update_post"

  delete '/post/:id/destroy',
    to: "posts#destroy",
    as: "destroy_post"

end
