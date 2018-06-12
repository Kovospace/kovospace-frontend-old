Rails.application.routes.draw do


  #devise_for :users
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

  get '/skill/new',
    to: "skills#new",
    as: "new_skill"

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


  devise_for :users, skip: :all

  devise_scope :user do

    get "/login",
      to: "devise/sessions#new",
      as: "new_user_session"

    # nvm
    post "/login",
      to: "devise/sessions#create",
      as: "user_session"

    # odhlasenie
    delete "/logout",
      to: "devise/sessions#destroy",
      as: "destroy_user_session"

    # nvm
    post "/password",
      to: "devise/passwords#create",
      as: "user_password"

    get "/password/new",
      to: "devise/passwords#new",
      as: "new_user_password"

    get "/password/edit",
      to: "devise/passwords#edit",
      as: "edit_user_password"

    patch "/password",
      to: "devise/passwords#update"

    put "/password",
      to: "devise/passwords#update"

    get "/settings/users/user/cancel",
      to: "devise/registrations#cancel",
      as: "cancel_user_registration"

    post "/",
      to: "devise/registrations#create",
      as: "user_registration"

    get "/register",
      to: "devise/registrations#new",
      as: "new_user_registration"

    get "/settings/users/user/edit",
      to: "devise/registrations#edit",
      as: "edit_user_registration"

    patch "/",
      to: "devise/registrations#update"

    put "/settings/users/user/edit",
      to: "devise/registrations#update"

    delete "/",
      to: "devise/registrations#destroy"

  end

end
