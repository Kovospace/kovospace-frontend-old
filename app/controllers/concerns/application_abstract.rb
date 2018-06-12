module ApplicationAbstract
    extend ActiveSupport::Concern

    def around_new
    end

    def around_edit
    end

    def around_create
    end

    def around_create_after_save
    end

    def around_update
    end

    def around_update_after_save
    end

    def load_vars
    end

    def load_new_edit_vars
    end

    def load_create_update_vars
    end

    def permitted_params
    end

end
