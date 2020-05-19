function Portfolio() {
    this.previewSwitcher;
    this.bgOffset;
    this.stylesFix;
    this.gallery;
    this.init();
}

Portfolio.prototype = {
    constructor: Portfolio,

    init: function() {
        this.previewSwitcher = new PreviewsSwitcher();
        this.bgOffset = new BgOffset();
        this.stylesFix = new DynamicStylesFix();
        this.gallery = new ImageGallery();
    },

    onready: function() {

    },

    onload: function() {

    },

    onturbolinks: function() {
        // fixnutie problemu vlozeneho CSS - ostava po prehliadani predosleho diela
        this.stylesFix.init();

        var container = $(document).find('header');
        if (container.hasClass('portfolios show')) {
            // offset nahladov v responsive rezime od menu
            this.bgOffset.offset();

            var toto = this;
            container.imagesLoaded(function() {
                // nahlady v responsive rezime hlavicky
                toto.previewSwitcher.init();
            });

            $(document).find('section#show_work').children('article').imagesLoaded(function() {
                toto.gallery.setup({
                    images_container: $(document).find('article').children('div'),
                    image_sizes: {
                        xxxl:1366,
                        xxl: 1024,
                        xl:  960,
                        l:   768,
                        m:   640,
                        s:   480,
                        xs:  360,
                        xxs: 320,
                    },
                    image_namespace: 'gallery_full_size',
                    preview_namespace: 'gallery_preview_size'
                });
                toto.gallery.init();
            });

        } else {
            // zastavit vymienanie nahladov, ide aj mimo stranky s projektom kvoli turbolinks js
            this.previewSwitcher.setVars();
            this.gallery.setVars();
        }
    }
}