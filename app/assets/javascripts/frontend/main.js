function Main() {
    this.Router;
    this.CurrentController;
}

Main.prototype = {
    constructor: Main,

    load: function() {
        var T = this;
        T.Router = new Router();
        //console.log('JS.load();');
        //this.CurrentController = this.Router.load();
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
    },

    prepareController: function() {
        /// TU JE CHYBA
        //console.log(this.CurrentController);
        //if (this.CurrentController === undefined) {
            //console.log(this.CurrentController);
            this.CurrentController = this.Router.load();
        //}
        console.log(this.CurrentController);
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
    },

    init_once: function() {
        if (this.CurrentController !== undefined) {
            var guard = window.initOnceGuard[this.Router.getControllerName()];

            //console.log(guard);

            if (guard===false||guard===undefined) {
                this.CurrentController.once();
            }
            
            /*var T = this;*/
            /*$(window).on("load", function() {
                T.CurrentController.onload();
            });*/

            window.initOnceGuard[this.Router.getControllerName()] = true
        }
    }
}

var JS = new Main();
JS.load();

