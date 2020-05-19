function ImageGallery() {
    this.scrolled;
    this.timer;
    this.images_list;
    this.images_ids;
    this.chosen_version;
    this.base_url;

    this.scroll_speed = 250;
    this.step = 128;
    this.close_timeout = 380;

    this.display_properties = {
        dpi: 1,
        width: 1
    };

    this.settings = {
        images_container: null,
        image_sizes: {},
        image_namespace: '',
        preview_namespace: ''
    };

    // spravit premazanie premennych tak ako pri pozadiach
    // upoader nekonvertuje niektore obrazky ak nedosiahnu poziadavky na resize to fit
    //
}

ImageGallery.prototype = {
    constructor: ImageGallery,

    setVars: function() {
        this.scrolled = 0;
        this.timer;
        this.images_list = [];
        this.images_ids = [];
        this.chosen_version = '';
        this.base_url = "";
    },

    determineDpi: function() {
        this.display_properties.dpi = window.devicePixelRatio;
        this.display_properties.width = $(window).width();
        //console.log(this.display_properties.dpi);
        //console.log(this.display_properties.width);
    },

    chooseVersion: function() {
        var w;
        var d;

        for (var key in this.settings.image_sizes) {
            if (!this.settings.image_sizes.hasOwnProperty(key)) continue;
            //console.log(this.settings.image_sizes[key]);
            if (this.settings.image_sizes[key] <= this.display_properties.width) {
                //console.log("mam");
                w = key;
                break;
            }
        }
        //console.log(w);
        d = Math.ceil(this.display_properties.dpi);
        if (d > 3) { d = 3; }
        this.chosen_version = (w + '_' + d + 'x')
        //console.log(this.chosen_version);
    },

    setup: function(settings) {
        //console.log(settings);
        this.setVars();
        this.determineDpi();
        this.settings = settings;
        this.chooseVersion();
    },

    init: function() {
        var totok = this;
        totok.loadImagesList();

        $(totok.settings.images_container).on('click', 'picture', function() {
            console.log('klik na obrazok');
            totok.openViewer($(this));
        });

        $(document).on('click', 'div.gallery', function() {
            totok.closeViewer($(this));
        });

        $(document).on('click', 'div.gallery > div.switcher > picture', function(e) {
            totok.selectImage($(this));
            totok.stopEvents(e);
        });

        $(document).on('click', 'div.body > span', function(e) {
            totok.switchImage($(this));
            totok.stopEvents(e);
        });

        $(document).on('click', 'div.gallery > div.switcher', function(e) {
            totok.stopEvents(e);
        });

        $(document).on('mousedown', 'div.gallery > div.switcher > span > p', function(e) {
            totok.scrollWithArrows($(this));
            totok.stopEvents(e);
        }).on('mouseup', 'div.gallery > div.switcher > span > p', function(e) {
            clearInterval(totok.timer);
            totok.stopEvents(e);
        });

        $(document).find('div.switcher').on('scroll', function() {
            totok.hideArrowsBasedOnScroll($(this));
        });

        $(document).on('click', 'div.body > picture > img', function(e) {
            totok.stopEvents(e);
        });

        $(document).on('change', 'div.switcher', function(e) {
            totok.alignScrollbar($(this));
            totok.stopEvents(e);
        });
    },

    loadImagesList: function() {
        var totok = this;
        //this.images_list = [];
        //this.images_ids = [];
        var imgs_obj = $(totok.settings.images_container).find('img');
        if (imgs_obj.length > 0) {
            var tmp = imgs_obj.first().attr('src');
            this.base_url = tmp.replace(/[a-z0-9\.\_]+$/, '');

            imgs_obj.each(function() {
                var url = $(this).attr('src');
                //console.log(url);
                var id = parseInt(url.match(/\/(\d+)\//)[1]);
                totok.images_ids.push(id);
                totok.images_list.push(totok.generateImageUrl(id));
                //totok.images_list.push(url);
            })
            //console.log(this.images_ids);
            //console.log(this.base_url);
        }
    },

    generateImageUrl: function(id) {
        var tmp = this.base_url.replace(/\/(\d+)\//, '/'+id+'/');
        //console.log(tmp);
        var img_url = tmp + this.settings.image_namespace + '_' + this.chosen_version + '.jpg';
        //console.log(img_url);
        return img_url;
    },

    generatePreviewUrl: function(id) {
        var tmp = this.base_url.replace(/\/(\d+)\//, '/'+id+'/');
        //console.log(tmp);
        var img_url = tmp + this.settings.preview_namespace + '_' + this.display_properties.dpi + 'x.jpg';
        //console.log(img_url);
        return img_url;
    },

    getIdFromUrl: function(url) {
        return parseInt(url.match(/\/(\d+)\//)[1]);
    },

    loadImagePreviews: function(ref) {
        prev_elem = ref.children('span.left');
        var no_of_images = this.images_ids.length;
        var totok = this;
        this.images_ids.forEach(function(id, index) {
            //var url = elem.replace('/max_', '/thumb_');
            var url = totok.generatePreviewUrl(id);
            //console.log(url);
            var new_elem = $('<picture id=\"gallery_prev_'+id+'\"><img src="'+url+'"></picture>');
            if (index == 0) { new_elem.addClass('first'); }
            if (index+1 == no_of_images) { new_elem.addClass('last'); }
            new_elem.insertAfter(prev_elem);
            prev_elem = new_elem;
        });
    },

    openViewer: function(pic) {
        //this.loadImagesList();
        console.log(this.images_list);
        $(document).find('div.gallery').css({'z-index':'99'});
        var sw = $(document).find('div.gallery').children('div.switcher');
        //console.log(sw);
        this.loadImagePreviews(sw);
        this.selectImage(pic);
        this.scrollHorizont(sw);
        this.hideArrowsBasedOnScroll(sw);
        $(document).find('body').hideScrollbars(true);
        $(document).find('div.gallery').addClass('visible');
    },

    closeViewer: function(gal) {
        var toto = this;
        var sw = gal.children('div.switcher');
        gal.removeClass('visible');
        //toto.images_list = [];
        //toto.images_ids = [];
        setTimeout(function() {
            $(document).find('body').hideScrollbars(false);
            sw.children('picture').remove();
            toto.scrolled = 0;
            sw.scrollLeft(0);
            $(document).find('div.gallery').css({'z-index':'-1'});
        }, this.close_timeout);
    },

    selectImage: function(pic) {
        var pic_to_show = "";
        if (typeof(pic) == "string") {
            pic_to_show = pic;
        } else {
            var id = this.getIdFromUrl(pic.children('img').attr('src'));
            pic_to_show = this.generateImageUrl(id);
        }
        //console.log(pic);
        //console.log(pic_to_show);
        var gallery = $(document).find('div.gallery');
        gallery.children('div.body').find('img').attr('src', pic_to_show);
        this.prelightSelectedIcon(this.getIdFromUrl(pic_to_show));
        $(document).find('div.switcher').trigger('change');
    },

    switchImage: function(ref) {
        var img_index = this.images_list.indexOf(
            $(document).find('div.gallery').find('img').attr('src')
        );
        if (ref.hasClass('left')) {
            this.prevImage(img_index);
        } else if (ref.hasClass('right')) {
            this.nextImage(img_index);
        } else if (ref.hasClass('close')) {
            this.closeViewer($('div.gallery'));
        }
    },

    prevImage: function(i) {
        var prev = (i == 0) ? (this.images_list.length-1) : (i-1);
        this.selectImage(this.images_list[prev]);
    },

    nextImage: function(i) {
        var next = (i+1 < this.images_list.length) ? i+1 : 0;
        this.selectImage(this.images_list[next]);
    },

    prelightSelectedIcon: function(id) {
        //console.log(id);
        $('div.switcher').find('picture').each(function() {
            if ($(this).attr('id').indexOf(id) !== -1) {
                $(this).addClass('selected');
            } else {
                $(this).removeClass('selected');
            }
        });
    },

    scrollHorizont: function(ref) {
        var toto = this;
        ref.mousewheel(function(event, delta) {
            this.scrollLeft -= delta * toto.step;
            event.preventDefault();
        });
    },

    hideArrowsBasedOnScroll: function(ref) {
        var left_arrow = ref.children('span.left');
        var right_arrow = ref.children('span.right');
        ref.waitForImages(function() {
            var full_width = $(this).get(0).scrollWidth;
            var scrolled = $(this).scrollLeft();
            if (scrolled <= 0) {
                left_arrow.addClass('hidden');
            } else {
                left_arrow.removeClass('hidden');
            }
            if (scrolled + $(this).width() == full_width) {
                right_arrow.addClass('hidden');
            } else {
                right_arrow.removeClass('hidden');
            }
        });
    },

    scrollWithArrows: function(ref) {
        var toto = this;
        var direction = ref.parent().attr('class');
        var sw = ref.closest('div.switcher');
        toto.scrolled = sw.scrollLeft();
        var smer;
        var fx;
        if (direction == 'left') { smer = -1; }
        else { smer = 1; }
        fx = function() {
            $('div.switcher')
                .stop()
                .animate({ scrollLeft: toto.scrolled+(toto.step*smer) }, toto.scroll_speed, function() {
                    toto.scrolled = sw.scrollLeft();
                });
        };
        this.timer = setInterval(fx, this.scroll_speed+100);
    },

    alignScrollbar: function(ref) {
        var padding = 24;
        var scrolled = ref.scrollLeft();
        var checked_element_pos = 0;
        var checked_element_width = 0;
        var selected_pic = ref.children('picture.selected');
        if (selected_pic.length > 0) {
            checked_element_pos = ref.children('picture.selected').position().left + scrolled;
            checked_element_width = ref.children('picture.selected').outerWidth();
        }
        var full_area_width = ref.get(0).scrollWidth;
        var visible_width = ref.width();
        var visible_range_start = scrolled;
        var visible_range_end = scrolled + visible_width;
        var misalign = 0;
        if (checked_element_pos + checked_element_width + padding == full_area_width) {
            misalign = full_area_width - visible_width;
        } else if (checked_element_pos == 0) {
            misalign = -scrolled;
        } else if (checked_element_pos - padding*2 <= visible_range_start) {
            misalign = -checked_element_width;
        } else if (checked_element_pos + checked_element_width + padding*2 >= visible_range_end) {
            misalign = checked_element_width;
        }
        ref.scrollLeft(scrolled + misalign);
    },

    stopEvents: function(e) {
        e.preventDefault();
        e.stopPropagation();
        e.stopImmediatePropagation();
    }

}
