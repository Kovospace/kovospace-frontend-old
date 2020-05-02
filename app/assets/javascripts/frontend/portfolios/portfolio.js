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
        if ($(document).find('header').attr('class') == 'portfolios show') {
            this.previewSwitcher.init();
        }
    },

    turbolinks_load: function() {

    }
}