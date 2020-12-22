function ImageGallery2Helper() {
    this.timer;
}

ImageGallery2Helper.prototype = {
    constructor: ImageGallery2Helper,

    determineDisplayProperties: function(ref) {
        var w;
        var d;
        var r;
        ref.VARS.dpr = Math.floor(window.devicePixelRatio);
        ref.VARS.screen_width = $(window).width();
        for (var key in ref.SETTINGS.images_responsive_sizes) {
            if (!ref.SETTINGS.images_responsive_sizes.hasOwnProperty(key)) continue;
            if (ref.SETTINGS.images_responsive_sizes[key] <= ref.VARS.screen_width) {
                w = key;
                r = ref.SETTINGS.images_responsive_sizes[key];
                break;
            }
        }
        d = Math.ceil(ref.VARS.dpr);
        if (d > 3) { d = 3; }
        ref.VARS.image_width = r;
        ref.VARS.image_size_string = (w + '_' + d + 'x');
    },

    populateListFromContainer: function(ref) {
        var toto = this;
        var images = ref.SETTINGS.images_container.find('img');
        var i = 0;
        images.each(function() {
            var orig_url = $(this).attr('src');
            var id = parseInt(orig_url.match(/\/(\d+)\//)[1]);
            var image = {
                index: i,
                id: id,
                image_url: toto.generateImageUrl(ref, id),
                preview_url: toto.generatePreviewUrl(ref, id)
            };
            ref.IMAGES.push(image);
            i++;
        });
    },

    populateListFromInputElems: function(ref) {
        var toto = this;
        var images = ref.SETTINGS.images_list;
        var i = 0;
        images.each(function() {
            var orig_url = $(this).val();
            var id = parseInt(orig_url.match(/\/(\d+)\//)[1]);
            var image = {
                index: i,
                id: id,
                image_url: toto.generateImageUrl(ref, id),
                preview_url: toto.generatePreviewUrl(ref, id)
            };
            ref.IMAGES.push(image);
            i++;
        });
    },

    generateImageUrl: function(ref, id) {
        return ref.SETTINGS.store_base_url + id + "/" + ref.SETTINGS.image_namespace + "_" + ref.VARS.image_size_string + ".jpg";
    },

    generatePreviewUrl: function(ref, id) {
        return ref.SETTINGS.store_base_url + id + "/" + ref.SETTINGS.preview_namespace + "_" + ref.VARS.dpr + "x.jpg";
    },

    getIdFromUrl: function(url) {
        return parseInt(url.match(/\/(\d+)\//)[1]);
    },

    getImageFromId: function(ref, id, type) {
        for (var i=0; i<ref.IMAGES.length; i++) {
            if (ref.IMAGES[i].id == id) {
                return ref.IMAGES[i];
            }
        }
    },

    loadImagePreviews: function(ref) {
        prev_elem = $(document).find('div.gallery').children('div.switcher').children('span.left');
        ref.IMAGES.forEach(function(image) {
            var new_elem = $('<picture id=\"gallery_prev_'+image.id+'\"><img src="'+image.preview_url+'"></picture>');
            if (image.index == 0) { new_elem.addClass('first'); }
            if (image.index+1 == ref.IMAGES.length) { new_elem.addClass('last'); }
            new_elem.insertAfter(prev_elem);
            prev_elem = new_elem;
        });
    },

    prelightSelectedIcon: function(id) {
        $('div.switcher').find('picture').each(function() {
            if ($(this).attr('id').indexOf("gallery_prev_"+id) !== -1) {
                $(this).addClass('selected');
            } else {
                $(this).removeClass('selected');
            }
        });
    },

    scrollHorizont: function(ref) {
        $(document).find('div.gallery').children('div.switcher').mousewheel(function(event, delta) {
            this.scrollLeft -= delta * ref.VARS.scroll_step;
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
            if (scrolled + $(this).width() >= full_width) {
                right_arrow.addClass('hidden');
            } else {
                right_arrow.removeClass('hidden');
            }
        });
    },

    scrollWithArrows: function(ref, elem) {
        var direction = elem.parent().attr('class');
        var sw = elem.closest('div.switcher');
        ref.VARS.scrolled = sw.scrollLeft();
        var smer;
        var fx;
        if (direction == 'left') { smer = -1; }
        else { smer = 1; }
        fx = function() {
            $('div.switcher')
                .stop()
                .animate({ scrollLeft: ref.VARS.scrolled+(ref.VARS.scroll_step*smer) }, ref.VARS.scroll_speed, function() {
                    ref.VARS.scrolled = sw.scrollLeft();
                });
        };
        ref.HELPER.timer = setInterval(function() {
            fx();
        }, ref.VARS.scroll_speed+100);
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

    changePreview: function(ref) {
        $(document).find('div.gallery').find('picture').imagesLoaded(function() {
            $(document).find('div.gallery').children('div.switcher').imagesLoaded(function() {
                ref.HELPER.prelightSelectedIcon(ref.CURRENT_IMAGE.id);
                ref.HELPER.scrollHorizont(ref);
                $(document).find('div.gallery').children('div.switcher').trigger('change');
            });    
        });
    },

    stopEvents: function(e) {
        e.preventDefault();
        e.stopPropagation();
        e.stopImmediatePropagation();
    },

    logBasics: function(ref) {
        console.log(ref.SETTINGS);
        console.log(ref.VARS);
        console.log(ref.IMAGES);
    }


}