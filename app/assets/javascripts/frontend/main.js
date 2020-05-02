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
            T.CurrentController = T.Router.load();
            if (T.CurrentController !== undefined) { T.init(); }
        });
    },

    init: function() {
        var T = this;

        $(document).ready(function() {
            T.CurrentController.onready();
        });

        $(window).on("load", function() {
             T.CurrentController.onload();
        });
    }
}

var JS = new Main();
JS.load();
//JS.init();
