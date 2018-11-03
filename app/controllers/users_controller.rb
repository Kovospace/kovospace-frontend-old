class UsersController < ApplicationController

    skip_filter *_process_action_callbacks.map(&:filter)

    layout "admin"

    def all
        @users = User.all
    end

    def show

    end

    def new
        @user = User.new
        generate_pass
        _load_vars
    end

    def create
        @user = User.new(
            permitted_params
        )
        _load_vars
        generate_email if @user.email.blank?
        if @user.save
            redirect_to(list_users_url)
        else
            generate_pass if @user.password.blank?
            render("new")
        end
    end

    def edit

    end

    def update

    end

    def destroy

    end

    private

    def _load_vars
        @roles = VirtualModel::UserRole.all
    end

    def generate_pass
        @user.password = (0...8).map { (65 + rand(26)).chr }.join
        @user.generated_password = @user.password
    end

    def generate_email
        @user.email = "#{@user.name}@example.com"
    end

    def permitted_params
         params[:user].permit(
            :name,
            :email,
            :password,
            :generated_password,
            :remember_me,
            :role
         )
    end

end
