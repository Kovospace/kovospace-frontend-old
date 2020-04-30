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
        var toto_base_adresses = this.base_adresses
        $(document).find('div.preview').children('figure').each(function() {
            var addr = $(this).children('picture').children('img').attr('src');
            toto_base_adresses.push(addr);
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
        return (id_of_visible === this.images_id);
    },

    preload: function() {
        var toto = this;
        //console.log(this.images.length);
        if (this.images.length === 0) {
        //if (this.images_loaded === false) {
            console.log("imagesov je nula");
            this.image_adresses.forEach(function(item) {
                var img = $('<img>').clone();
                img.on('load', function() {
                    toto.images_loaded++;
                    if (toto.images_loaded == toto.images.length) {
                        //allImagesLoaded();
                        toto.all_preloaded = true;
                        console.log("vsjo v pariadke");
                    }
                });
                img.attr('src', item);
                toto.images.push(img);
            });
            //console.log(this.images);
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
                toto.append(toto.images);
            } else {
                console.log('render() - obrazky neboli este nacitane');
                if (toto.preload_runned === false) {
                    console.log('render() - a este ani spusteny loader');
                    toto.preload();
                    toto.preload_runned = true;
                }
            }
        }, 100);

        /*if (this.all_preloaded === true) {
            console.log('render() - obrazky nacitane');
            clearTimeout(this.poll_timer);
            this.append();
        } else {
            var toto = this;
            console.log('render() - obrazky neboli este nacitane');
            if (this.preload_runned === false) {
                console.log('render() - a este ani spusteny loader');
                this.preload();
                this.preload_runned = true;
            }
            this.poll_timer = setTimeout(function(){
                toto.render();
            }, this.poll_timeout);
        }*/
        //console.log(this.images);
    },

    append: function(images) {

        //console.log(this.images);

        var index = 0;
        var toto = this;
        $(document).find('div.preview').children('figure').each(function() {
            var img = $(this).children('picture').children('img');
            //img.css({'opacity':'0'});
            //console.log(toto.images[index].attr('src'));
            //console.log(images);
            //console.log(toto.images[index].attr('src'));
            //img.attr('src', toto.images[index].attr('src'));
            //img.css({'opacity':'1'});
            index++;
        });
    }

}