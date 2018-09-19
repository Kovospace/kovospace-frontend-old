Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
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
    to: 'admin#list_homepage',
    as: 'admin'

  get "/admin/homepage",
    to: "admin#list_homepage",
    as: "list_homepage"

### HLAVNA STRANKA

  # skills

  get '/skill',
    to: "skills#index",
    as: "skills"

  get '/skill/new',
    to: "skills#new",
    as: "new_skill"

  get '/skill/:id/edit',
    to: "skills#edit",
    as: "edit_skill"

  post '/skill',
    to: "skills#create"

  patch '/skill.:id',
    to: "skills#update",
    as: "update_skill"

  delete '/skill.:id',
    to: "skills#destroy",
    as: "destroy_skill"

  # popis progresu na skilloch

  get '/work_state',
    to: "work_states#index",
    as: "work_states"

  get "/admin/work_states",
    to: "admin#list_work_states",
    as: "list_work_states"

  get '/work_state/new',
    to: "work_states#new",
    as: "new_work_state"

  get '/work_state/:id/edit',
    to: "work_states#edit",
    as: "edit_work_state"

  post '/work_state',
    to: "work_states#create"

  patch '/work_state.:id',
    to: "work_states#update",
    as: "update_work_state"

  delete '/work_state.:id',
    to: "work_states#destroy",
    as: "destroy_work_state"

  # kontaktny formular

  get '/contact',
    to: "contacts#index",
    as: "contacts"

  get "/admin/contacts",
    to: "admin#list_contacts",
    as: "list_contacts"

  get '/contact/new',
    to: "contacts#new",
    as: "new_contact"

  get '/contact/:id/edit',
    to: "contacts#edit",
    as: "edit_contact"

  get '/contact/:id',
    to: "contacts#show",
    as: "show_contact"

  post '/contact',
    to: "contacts#create"

  post '/contact/:id/seen',
    to: "contacts#seen"

  post '/contact/:id/unseen',
    to: "contacts#unseen"

  patch '/contact.:id',
    to: "contacts#update",
    as: "update_contact"

  delete '/contact.:id',
    to: "contacts#destroy",
    as: "destroy_contact"

  # novinky

  get '/newslog',
    to: "newslogs#index",
    as: "newslogs"

  get "/admin/newslogs",
    to: "admin#list_newslogs",
    as: "list_newslogs"

  get '/newslog/new',
    to: "newslogs#new",
    as: "new_newslog"

  get '/newslog/:id/edit',
    to: "newslogs#edit",
    as: "edit_newslog"

  post '/newslog',
    to: "newslogs#create"

  patch '/newslog.:id',
    to: "newslogs#update",
    as: "update_newslog"

  delete '/newslog.:id',
    to: "newslogs#destroy",
    as: "destroy_newslog"

### portfolio

  get '/portfolio',
    to: "portfolios#index",
    as: "portfolios"

  get "/admin/portfolio",
    to: "admin#list_portfolios",
    as: "list_portfolio"

  get '/portfolio/new',
    to: "portfolios#new",
    as: "new_portfolio"

  get '/portfolio/:id/edit',
    to: "portfolios#edit",
    as: "edit_portfolio"

  post '/portfolio',
    to: "portfolios#create"

  patch '/portfolio.:id',
    to: "portfolios#update",
    as: "update_portfolio"

  delete '/portfolio.:id',
    to: "portfolios#destroy",
    as: "destroy_portfolio"

### blog

  # kategorie

  get '/blog',
    to: "blogs#index",
    as: "blogs"

  get "/admin/blogs",
    to: "admin#list_blogs",
    as: "list_blogs"

  get '/blog/new',
    to: "blogs#new",
    as: "new_blog"

  get '/blog/:id/edit',
    to: "blogs#edit",
    as: "edit_blog"

  post '/blog',
    to: "blogs#create"

  patch '/blog.:id',
    to: "blogs#update",
    as: "update_blog"

  delete '/blog.:id',
    to: "blogs#destroy",
    as: "destroy_blog"

  # clanky

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
   # post "/password",
     # to: "devise/passwords#create",
     # as: "user_password"

    get "/password/new",
      to: "devise/passwords#new",
      as: "new_user_password"

   get "/password/edit",
     to: "devise/passwords#edit",
     as: "edit_user_password"

   # patch "/password",
    #  to: "devise/passwords#update"

   # put "/password",
    #  to: "devise/passwords#update"

    #get "/settings/users/user/cancel",
     # to: "devise/registrations#cancel",
     # as: "cancel_user_registration"

   # post "/",
     # to: "devise/registrations#create",
     # as: "user_registration"

   # get "/register",
     # to: "devise/registrations#new",
     # as: "new_user_registration"

    #get "/settings/users/user/edit",
     # to: "devise/registrations#edit",
     # as: "edit_user_registration"

   # patch "/",
     # to: "devise/registrations#update"

   # put "/settings/users/user/edit",
    #  to: "devise/registrations#update"

    #delete "/",
     # to: "devise/registrations#destroy"

  end

end
