function Portfolio() {
    this.previewSwitcher;
    this.init();
}

Portfolio.prototype = {
    constructor: Portfolio,

    init: function() {
        this.previewSwitcher = new PreviewsSwitcher();
    },

    onready: function() {
        //alert("dopiciiii");
        this.previewSwitcher.init();
    }
}