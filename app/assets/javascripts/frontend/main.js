function Main() {
    this.Router;
    this.CurrentController;
}

Main.prototype = {
    constructor: Main,

    load: function() {
        var T = this;
        T.Router = new Router();
        window.initOnceGuard = []

        $(document).ready(function() {
            T.prepareController();
            T.init_ready();
            T.init_once();
        });

        // turbolinks - firuje aj pri onready
        $(document).on('turbolinks:load', function() {
            T.prepareController();
            T.init_turbo();
            T.init_once();
        });

        $(document).on('turbolinks:before-cache', function() {
           T.before_cache();
        });

        $(document).on('turbolinks:before-render', function() {
            T.before_render();
        });
    },

    prepareController: function() {
        /// TU JE CHYBA
        //console.log(this.CurrentController);
        //if (this.CurrentController === undefined) {
            //console.log(this.CurrentController);
            this.CurrentController = this.Router.load();
        //}
        //console.log(this.CurrentController);
    },

    init_ready: function() {
        if (this.CurrentController !== undefined) {
            console.log("on ready");
            this.CurrentController.onready();
        }
    },

    init_turbo: function() {
        if (this.CurrentController !== undefined) {
            console.log("on turbolinks");
            this.CurrentController.onturbolinks();
            var T = this;
            $(window).on("load", function() {
                T.CurrentController.onload();
            });
        }
    },

    init_once: function() {
        if (this.CurrentController !== undefined) {
            if (this.CurrentController.once !== undefined) {
                var guard = window.initOnceGuard[this.Router.getControllerName()];
                if (guard===false||guard===undefined) {
                    this.CurrentController.once();
                }
                window.initOnceGuard[this.Router.getControllerName()] = true
            }
        }
    },

    before_cache: function() {
        if (this.CurrentController !== undefined) {
            if (this.CurrentController.onbeforecache !== undefined) {
                console.log("before cache");
                this.CurrentController.onbeforecache();
            }
        }
    },

    before_render: function() {
        if (this.CurrentController !== undefined) {
            if (this.CurrentController.onbeforerender !== undefined) {
                console.log("before redner");
                this.CurrentController.onbeforerender();
            }
        }
    }
}

var JS = new Main();
JS.load();

