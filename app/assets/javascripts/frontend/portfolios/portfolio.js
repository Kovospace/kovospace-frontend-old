window.GALLERY2 = new ImageGallery2();
window.RESPONSIVE_HEAD_PREVIEW = new PreviewsSwitcher();

function Portfolio() {
    this.bgOffset;
    this.stylesFix;
    this.init();
}

Portfolio.prototype = {
    constructor: Portfolio,

    init: function() {
        this.bgOffset = new BgOffset();
        this.stylesFix = new DynamicStylesFix();
    },

    onready: function() {

    },

    onload: function() {

    },

    once: function() {

    },

    onturbolinks: function() {
        var toto = this;
        var container = $(document).find('header');

        // fixnutie problemu vlozeneho CSS - ostava po prehliadani predosleho diela
        this.stylesFix.init();

        if (container.hasClass('portfolios show')) {

            // offset nahladov v responsive rezime od menu
            this.bgOffset.offset();

            // nahlady v responsive rezime hlavicky
            container.imagesLoaded(function() {
                window.RESPONSIVE_HEAD_PREVIEW.init();
            });

            // obrazky v texte
            $(document).find('section#show_work').children('article').imagesLoaded(function() {
                window.GALLERY2.setup({
                    id:                         $('input#portfolio_id').val(),
                    images_container:           $(document).find('article').children('div'),
                    images_list:                null,
                    images_responsive_sizes:    {
                                                    xxxl:1366,
                                                    xxl: 1024,
                                                    xl:  960,
                                                    l:   768,
                                                    m:   640,
                                                    s:   480,
                                                    xs:  360,
                                                    xxs: 320,
                                                },
                    store_base_url:             "/uploads/portfolio_gallery/image/",
                    image_namespace:            "gallery_full_size",
                    preview_namespace:          "gallery_preview_size"
                });
                window.GALLERY2.init();
            });

        } else {

            // zastavit vymienanie nahladov, ide aj mimo stranky s projektom kvoli turbolinks js
            window.RESPONSIVE_HEAD_PREVIEW.setVars();
            //this.gallery.setVars();

            //$(document).on('click', 'a.gallery_starter', function(e) {
            $(document).find('a.gallery_starter').click(function(e) {
                e.preventDefault();

                var imagesList = $(this).closest('article').children('input[type=hidden]');
                
                window.GALLERY2.setup({
                    id:                         $('input#portfolio_id').val(),
                    images_container:           null,
                    images_list:                imagesList,
                    images_responsive_sizes:    {
                                                    xxxl:1366,
                                                    xxl: 1024,
                                                    xl:  960,
                                                    l:   768,
                                                    m:   640,
                                                    s:   480,
                                                    xs:  360,
                                                    xxs: 320,
                                                },
                    store_base_url:             "/uploads/portfolio_gallery/image/",
                    image_namespace:            "gallery_full_size",
                    preview_namespace:          "gallery_preview_size"
                });

                window.GALLERY2.init();
                window.GALLERY2.open();

                $(document).find('head').find('style').remove();
                var style = $(this).css('background-color');
                var tmp = "<style>div.gallery div.switcher picture.selected { border-color:";
                var tmp2 = "; }</style>";
                $(tmp.concat(style, tmp2)).appendTo('head');
                $(this).data('gallery-clicked', 'true');
                //$(document).find('head').find('style').remove();
            });

        }
    }
}