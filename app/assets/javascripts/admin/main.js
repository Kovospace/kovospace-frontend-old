function Main() {
    this.Router;
    this.CurrentController;
}

Main.prototype = {
    constructor: Main,

    init: function() {
        var T = this;
        T.Router = new Router();

        $(document).ready(function() {
            T.CurrentController = T.Router.load();
            T.CurrentController.onready();
        });
    }
}

var JS = new Main();
JS.init();
