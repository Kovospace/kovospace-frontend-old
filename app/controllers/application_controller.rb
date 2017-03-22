class ApplicationController < ActionController::Base

    include ApplicationConcern

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    def initialize
      super
      @singular_varname = "@#{controller_name.singularize}"
      @plural_varname = "@#{controller_name.pluralize}"
      @model = model_exist?
    end

    before_action :index_action, only: :index

    before_action :new_action, only: :new

    before_action :create_action, only: :create

    before_action :edit_action, only: :edit

    before_action :update_action, only: :update

    before_action :destroy_action, only: :destroy

    def index_action
      instance_variable_set(@plural_varname, @model.all) if @model
    end

    def show_action

    end

    def new_action
      instance_variable_set(@singular_varname, @model.new) if @model
      load_form_vars
    end

    def create_action 
      instance_variable_set(
        @singular_varname,
        @model.new(permitted_params)
      )
      if instance_variable_get(@singular_varname).save
        redirect_to public_send("#{controller_name.pluralize}_path")
      else
         render "new"
      end
    end

    def edit_action
      instance_variable_set(
        @singular_varname,
        @model.find(params[:id])
      )
      load_form_vars
    end

    def update_action
      tmp = edit_action
      if tmp.update(permitted_params)
        redirect_to controller: controller_name, action: 'index'
      else
        render "new"
      end
    end

    def destroy_action
      tmp = edit_action
      tmp.destroy
      redirect_to controller: controller_name, action: 'index'
    end

    def index

    end

    def show

    end

    def new 
      
    end

    def create

    end

    def edit
      render "new"
    end

    def update

    end

    def delete

    end

    def destroy

    end

    private

    def load_form_vars

    end

end
