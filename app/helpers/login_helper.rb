module LoginHelper

    def cookie_permissions_warn
        if @accept_cookie["personal"] != "1"
            return "Pre použitie voľby na zapamätanie si prihlásenia je potrebné
                #{link_to('upraviť nastavenia Cookies', cookies_path, rel: 'nofollow')}
                <br>
                - povoliť kategóriu \"Osobné\"".html_safe
        end
    end

    def remember_disabled_class
        return "disabled" if @accept_cookie["personal"] != "1"
    end

end
