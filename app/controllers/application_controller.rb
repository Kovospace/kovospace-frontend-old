class ApplicationController < ActionController::Base

    include ApplicationConcern
    include BeforeRender
    include ApplicationAbstract
    require 'naturally'

    layout :_choose_layout

    protect_from_forgery with: :exception

    before_action :store_user_location!, if: :storable_location?

    #before_action :authenticate_user!, only: :admin

    before_action :init

    before_action :cookies_accept

    before_action :index_action, only: :index

    before_action :show_action, only: :show

    before_action :new_action, only: :new

    before_action :create_action, only: :create, if: :create_action_validation

    before_action :edit_action, only: :edit

    before_action :update_action, only: :update

    before_action :destroy_action, only: :destroy, if: :user_signed_in?

    before_action :_load_vars, only: [:new, :edit, :update, :create]

    before_action :set_path_back, only: [:index]

    before_action :get_path_back, only: [:show]

    def index
    end

    def show
    end

    def new
    end

    def create
      create_action_2
    end

    def edit
      render "new"
    end

    def update
      update_action_2
    end

    def delete
    end

    def destroy
    end

    private

    def init
      @singular_varname = "@#{controller_name.singularize}"
      @plural_varname = "@#{controller_name.pluralize}"
      @model = model_exist?
    end

    def index_action
      instance_variable_set(@plural_varname, @model.all) if @model
    end

    def show_action
      instance_variable_set(
        @singular_varname,
        @model.find(params[:id])
      )
    end

    def new_action
      instance_variable_set(@singular_varname, @model.new) if @model
      _around_new
    end

    def create_action
      #if user_signed_in?
      if @model
        instance_variable_set(
          @singular_varname,
          @model.new(_permitted_params)
        )
      end
      _around_create
    end

    def create_action_2
      saved = instance_variable_get(@singular_varname).save
      _around_create_after_save
      if saved
        _after_save_ok
        if !(r = _after_ok_redirect_to).nil?
          redirect_to r
        else
          redirect_to public_send("#{controller_name.pluralize}_path")
        end
      else
        _after_save_fail
        render "new"
      end
    end

    def edit_action
      instance_variable_set(
        @singular_varname,
        @model.find(params[:id])
      )
      _around_edit
    end

    def update_action
      instance_variable_set(
        @singular_varname,
        @model.find(params[:id])
      )
    end

    def update_action_2
      _around_update
      saved = instance_variable_get(@singular_varname).update(_permitted_params)
      _around_update_after_save
      if saved
        _after_save_ok
        if !(r = _after_ok_redirect_to).nil?
          redirect_to r
        else
          redirect_to controller: controller_name, action: 'index'
        end
      else
        _after_save_fail
        render "new"
      end
    end

    def destroy_action
      if @model
        @model.find(params[:id]).destroy
        if !(r = _after_ok_redirect_to).nil?
          redirect_to r
        else
          redirect_to controller: controller_name, action: 'index'
        end
      end
    end

    def cookies_accept
      if !(c = cookies[:remember_cookies_accept]).nil?
        @accept_cookie = JSON.parse(c)[0]
      else
        @accept_cookie = {}
      end
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end

    def under_construction
        redirect_to '/under_construction'
    end

end
