function Preview(num) {
    this.image_order = num;
    this.addr_id_regex = /(^.+\/)(\d+)(\/.+$)/;
    this.all_preloaded = false;
    this.preload_runned = false;
    this.images_loaded = 0;
    this.poll_timeout = 100;

    this.poll_timer;
    this.images_id;
    this.base_adresses = [];
    this.base_images = [];
    this.image_adresses = [];
    this.images = [];

    this.init();
}

Preview.prototype = {
    constructor: Preview,

    init: function() {
        this.extractBaseAdresses()
        this.urlFromOrder();
    },

    extractBaseAdresses: function() {
        var toto = this;
        $(document).find('div.preview').children('figure').each(function() {
            var img = $(this).children('picture').children('img');
            toto.base_images.push(img);
            var addr = img.attr('src');
            toto.base_adresses.push(addr);
        });
    },

    urlFromOrder: function() {
        var toto = this;
        // id by malo byt vzdy rovnake pre skupinu obrazkov
        var input = $(document).find('div.previews_ids').find('input#bg_images_id_'+(this.image_order-1));
        this.images_id = parseInt(input.val());
        this.base_adresses.forEach(function(item) {
            var url = item.replace(toto.addr_id_regex, "$1"+toto.images_id+"$3");
            toto.image_adresses.push(url);
        });
    },

    isCurrent: function() {
        var tmp_addr = $(document).find('div.preview').children('figure').first().children('picture').children('img').attr('src');
        var id_of_visible = parseInt(tmp_addr.match(this.addr_id_regex)[2]);
        if (id_of_visible === this.images_id) {
            if (this.all_preloaded === false) {
                this.images = this.base_images;
                this.all_preloaded = true;
            }
            return true;
        } else {
            return false;
        }
    },

    preload: function() {
        var toto = this;
        if (this.images.length === 0) {
            console.log("imagesov je nula");
            this.image_adresses.forEach(function(item) {
                var img = $('<img>');//.clone();
                img.on('load', function() {
                    toto.images_loaded++;
                    if (toto.images_loaded == toto.images.length) {
                        toto.all_preloaded = true;
                    }
                });
                img.attr('src', item);
                toto.images.push(img);
            });
        }
    },

    render: function() {
        // dosetrit ak subor neexistuje, vtedy bezi poll timer donekonecna
        var toto = this;
        this.poll_timer = setInterval(function() {
            if (toto.all_preloaded === true) {
                console.log('render() - obrazky nacitane');
                clearInterval(toto.poll_timer);
                toto.append();
            } else {
                console.log('render() - obrazky neboli este nacitane');
                if (toto.preload_runned === false) {
                    console.log('render() - a este ani spusteny loader');
                    toto.preload();
                    toto.preload_runned = true;
                }
            }
        }, this.poll_timeout);
    },

    append: function() {
        var index = 0;
        var toto = this;
        $(document).find('div.preview').children('figure').each(function() {
            var pic_elem = $(this).children('picture');
            pic_elem.children('img').css({'opacity':'0'});
            var tuto = $(this);
            var i = index;
            setTimeout(function() {
                pic_elem.empty();
                toto.images[i].css({'opacity':'0'});
                toto.images[i].appendTo(tuto.children('picture'));
                setTimeout(function() {
                    toto.images[i].css({'opacity':'1'});
                }, 10);
            }, 490);
            index++;
        });
        $(document).find('ul.preview_switcher').find('a').removeClass('active').removeClass('fakehover');
        $(document).find('ul.preview_switcher').find('a#nahlad_'+toto.image_order).addClass('fakehover active');
    }

}