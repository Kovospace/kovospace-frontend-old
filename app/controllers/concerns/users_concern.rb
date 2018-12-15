module UsersConcern
    extend ActiveSupport::Concern

    included do
        before_action :backpath, only: :new
    end

    def after_sign_in_path_for(resource_or_scope)
       stored_location_for(resource_or_scope) || super
    end

    def backpath
        @backpath = stored_location_for(:user)
    end

end
