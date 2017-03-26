class ApplicationController < ActionController::Base

    include ApplicationConcern
    include BeforeRender
    include ClassOnInputWithError
    

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

    before_action :edit_action, only: [:edit, :update]

    before_action :destroy_action, only: :destroy

    before_action :load_new_edit_vars, only: [:new, :edit]

    before_render :load_create_update_vars, only: [:update, :create]


    def index_action
      instance_variable_set(@plural_varname, @model.all) if @model
    end

    def show_action

    end

    def new_action
      instance_variable_set(@singular_varname, @model.new) if @model
    end

    def create_action 
      instance_variable_set(
        @singular_varname,
        @model.new(permitted_params)
      )
    end

    def create_action_2
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
    end

    def update_action_2
      if instance_variable_get(@singular_varname).update(permitted_params)
        redirect_to controller: controller_name, action: 'index'
      else
        render "new"
      end
    end

    def destroy_action
      @model.find(params[:id]).destroy
      redirect_to controller: controller_name, action: 'index'
    end

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

    def load_new_edit_vars

    end

    def load_create_update_vars

    end

end
