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
        //console.log(this.base_adresses);
        //console.log(this.base_adresses[0].match(this.addr_id_regex)[2]);
    },

    urlFromOrder: function() {
        var toto = this;
        // id by malo byt vzdy rovnake pre skupinu obrazkov
        var input = $(document).find('div.previews_ids').find('input#bg_images_id_'+(this.image_order-1));
        //console.log(input);
        this.images_id = parseInt(input.val());
        //console.log(this.images_id);
        /*var toto_image_adresses = this.image_adresses;
        var toto_addr_id_regex = this.addr_id_regex;
        var toto_images_id = this.images_id;*/
        this.base_adresses.forEach(function(item) {
            var url = item.replace(toto.addr_id_regex, "$1"+toto.images_id+"$3");
            toto.image_adresses.push(url);
        });
        //console.log(this.image_adresses);
    },

    isCurrent: function() {
        var tmp_addr = $(document).find('div.preview').children('figure').first().children('picture').children('img').attr('src');
        var id_of_visible = parseInt(tmp_addr.match(this.addr_id_regex)[2]);
        //console.log(id_of_visible);
        //console.log(this.images_id);
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
        //console.log(this.images.length);
        if (this.images.length === 0) {
        //if (this.images_loaded === false) {
            console.log("imagesov je nula");
            this.image_adresses.forEach(function(item) {
                var img = $('<img>');//.clone();
                img.on('load', function() {
                    toto.images_loaded++;
                    if (toto.images_loaded == toto.images.length) {
                        //allImagesLoaded();
                        toto.all_preloaded = true;
                        //console.log("vsjo v pariadke");
                    }
                });
                img.attr('src', item);
                toto.images.push(img);
            });
            //console.log(this.images);
            //console.log("preload");
        }
    },

    render: function() {
        // dosetrit ak subor neexistuje, vtedy bezi poll timer donekonecna
        //console.log(this.images);
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
        //console.log(this.images);
        var index = 0;
        var toto = this;
        $(document).find('div.preview').children('figure').each(function() {
            var pic_elem = $(this).children('picture');
            pic_elem.children('img').css({'opacity':'0'});
            var tuto = $(this);
            var i = index;
            setTimeout(function() {
                pic_elem.empty();
                /*setTimeout(function() {
                    $(document).find('ul.preview_switcher').find('a').removeClass('active').removeClass('fakehover');
                }, 10);*/
                //console.log(tamto.images);
                //console.log(toto.images);
                //console.log(i);
                toto.images[i].css({'opacity':'0'});
                toto.images[i].appendTo(tuto.children('picture'));
                setTimeout(function() {
                    toto.images[i].css({'opacity':'1'});
                    //$(document).find('ul.preview_switcher').find('a#nahlad_'+toto.image_order).addClass('fakehover active');
                }, 10);
                //pic_elem.children('img').css({'opacity':'1'});
            }, 490);
            index++;
        });
        $(document).find('ul.preview_switcher').find('a').removeClass('active').removeClass('fakehover');
        $(document).find('ul.preview_switcher').find('a#nahlad_'+toto.image_order).addClass('fakehover active');
    }

}