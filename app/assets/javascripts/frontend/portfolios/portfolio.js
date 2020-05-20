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
        var toto = this;
        var container = $(document).find('header');

        // fixnutie problemu vlozeneho CSS - ostava po prehliadani predosleho diela
        this.stylesFix.init();

        if (container.hasClass('portfolios show')) {

            // offset nahladov v responsive rezime od menu
            this.bgOffset.offset();

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

            $(document).on('click', 'a.gallery_starter', function(e) {
                e.preventDefault();
                console.log('stlaceny spustac galerie');
                toto.gallery.setup({
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
                    preview_namespace: 'gallery_preview_size',
                    images_list_container: $(this).closest('article')
                });
                toto.gallery.init();

                $(document).find('head').find('style').remove();
                var style = $(this).css('background-color');
                var tmp = "<style>div.gallery div.switcher picture.selected { border-color:";
                var tmp2 = "; }</style>";
                $(tmp.concat(style, tmp2)).appendTo('head');
                //$(document).find('head').find('style').remove();
            });

        }
    }
}