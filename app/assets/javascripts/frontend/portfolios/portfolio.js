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

    },

    onload: function() {

    },

    onturbolinks: function() {
        this.bgOffset.offset();
        // zastavit ho, ide aj mimo stranky s projektom kvoli turbolinks js
        var container = $(document).find('header');
        if (container.hasClass('portfolios show')) {
            this.bgOffset.offset();
            var toto = this;
            container.imagesLoaded(function() {
                toto.previewSwitcher.init();
            });
        } else {
            this.previewSwitcher.setVars();
        }
    }
}