function ImageGallery2() {
    this.HELPER = new ImageGallery2Helper();
    this.HANDLERS = new ImageGallery2Handlers();
    this.SETTINGS;
    this.VARS;
    this.IMAGES;
    this.CURRENT_IMAGE;
    //this.setVars();
}

ImageGallery2.prototype = {
    constructor: ImageGallery2,

    setVars: function() {
        this.SETTINGS = {
            id: null,                       // id of post with images
            images_container: null,         // show action - listing images from page
            images_list: null,              // index/search action - listing images from hidden input
            images_responsive_sizes: {},    //
            store_base_url: null,           // root for gallery images
            image_namespace: null,
            preview_namespace: null
        };
        this.VARS = {
            dpi: 1,
            dpr: 1,
            screen_width: 1024,
            image_width: 320,
            image_size_string: "",
            close_timeout: 380,
            scrolled: 0,
            scroll_step: 128,
            scroll_speed: 250
        };
        this.IMAGES = [];
        this.CURRENT_IMAGE = null;
    },

    setup: function(settings) {
        this.setVars();
        this.SETTINGS = settings;
    },

    init: function() {
        this.HELPER.determineDisplayProperties(this);
        this.HANDLERS.handle(this);
        if (this.SETTINGS.images_container !== null) {
            // show action
            this.HELPER.populateListFromContainer(this);
        } else {
            // index action
            this.HELPER.populateListFromInputElems(this);
        }
    },

    open: function(trigger_elem) {
        $(document).find('div.gallery').css({'z-index':'99'});
        if (trigger_elem !== undefined) {
            // show action
            var id = this.HELPER.getIdFromUrl($(trigger_elem).attr('src'));
            this.show(id);
        } else {
            console.log('index');
            // index action
            this.show(this.IMAGES[0].id);
        }
        this.HELPER.loadImagePreviews(this);
        $(document).find('body').hideScrollbars(true);
        $(document).find('div.gallery').addClass('visible');
    },

    close: function() {
        var toto = this;
        var gal = $(document).find('div.gallery').removeClass('visible');
        setTimeout(function() {
            $(document).find('body').hideScrollbars(false);
            var sw = $(document).find('div.gallery').children('div.switcher');
            sw.children('picture').remove();
            toto.VARS.scrolled = 0;
            sw.scrollLeft(0);
            $(document).find('div.gallery').css({'z-index':'-1'});
        }, this.VARS.close_timeout);
    },

    prev: function() {
        var prev = (this.CURRENT_IMAGE.index == 0) ? (this.IMAGES.length-1) : (this.CURRENT_IMAGE.index-1);
        this.show(this.IMAGES[prev].id);
    },

    next: function() {
        var next = (this.CURRENT_IMAGE.index+1 < this.IMAGES.length) ? this.CURRENT_IMAGE.index+1 : 0;
        this.show(this.IMAGES[next].id);
    },

    show: function(id) {
        var toto = this;
        this.CURRENT_IMAGE = this.HELPER.getImageFromId(this, id);
        $(document).find('div.gallery').children('div.body').find('img').attr('src', this.CURRENT_IMAGE.image_url);
        this.HELPER.changePreview(this);
    }
    
}