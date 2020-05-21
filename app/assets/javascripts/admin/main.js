function Main() {
    this.Router;
    this.CurrentController;
}

Main.prototype = {
    constructor: Main,

    load: function() {
        var T = this;
        T.Router = new Router();

        $(document).ready(function() {
            T.prepareController();
            T.init_ready();
        });

        // turbolinks - firuje aj pri onready
        $(document).on('turbolinks:load', function() {
            T.prepareController();
            T.init_turbo();
        });
    },

    prepareController: function() {
        if (this.CurrentController === undefined) {
            this.CurrentController = this.Router.load();
        }
    },

    init_ready: function() {
        if (this.CurrentController !== undefined) {
            this.CurrentController.onready();
        }
    },

    init_turbo: function() {
        if (this.CurrentController !== undefined) {
            this.CurrentController.onturbolinks();
            var T = this;
            $(window).on("load", function() {
                T.CurrentController.onload();
            });
        }
    }
}

var JS = new Main();
JS.load();

