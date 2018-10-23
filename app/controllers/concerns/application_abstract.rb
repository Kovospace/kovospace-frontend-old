module ApplicationAbstract
    extend ActiveSupport::Concern

    def _around_new
    end

    def _around_edit
    end

    def _around_create
    end

    def _around_create_after_save
    end

    def _after_ok_redirect_to
        nil
    end

    def _around_update
    end

    def _around_update_after_save
    end

    def _load_vars
    end

    def _load_new_edit_vars
    end

    def _load_create_update_vars
    end

    def _permitted_params
    end

    def _after_save_ok

    end

end
