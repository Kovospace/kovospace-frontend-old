function Portfolio() {
    this.previewSwitcher;
    this.bgOffset;
    this.init();
}

Portfolio.prototype = {
    constructor: Portfolio,

    init: function() {
        this.previewSwitcher = new PreviewsSwitcher();
        this.bgOffset = new BgOffset();
    },

    onready: function() {
        this.bgOffset.offset();
    },

    onload: function() {
        this.previewSwitcher.init();
    }
}