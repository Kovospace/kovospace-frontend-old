Rails.application.routes.draw do


  devise_for :users
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

  get 'admin',
    to: 'admin#index',
    as: 'admin'



get '/skill',
    to: "skills#index",
    as: "skills"

 get "/admin/skills",
    to: "admin#list_skills",
    as: "list_skills"

 get '/skill/:id/edit',
    to: "skills#edit",
    as: "edit_skill"

 delete '/skill.:id',
    to: "skills#destroy",
    as: "destroy_skill"



  ### articles page

  get '/post',
    to: "posts#index",
    as: "posts"

  get "/admin/posts",
    to: "admin#list_posts",
    as: "list_posts"

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
