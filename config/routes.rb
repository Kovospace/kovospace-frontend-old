Rails.application.routes.draw do

  ### set up homepage
  root to: 'homepage#index'

  get 'home',
    to: "homepage#index",
    as: "home"

  get 'blog',
    to: "blogs#index",
    as: "blog"

  get 'portfolio',
    to: "portfolios#index",
    as: "portfolio"



  ### articles page

  get '/post',
    to: "posts#index",
    as: "posts"

  get '/post/new',
    to: "posts#new",
    as: "new_post"

  get '/post/:id/edit',
    to: "posts#edit",
    as: "edit_post"

  post '/post',
    to: "posts#create"

  patch '/post.:id',
    to: "posts#update",
    as: "update_post"

  delete '/post.:id',
    to: "posts#destroy",
    as: "destroy_post"

end
