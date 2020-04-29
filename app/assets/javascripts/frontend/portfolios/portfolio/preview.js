function Preview(num) {
    this.image_order = num;
    this.addr_id_regex = /(^.+\/)(\d+)(\/.+$)/;
    this.all_preloaded = false;

    this.images_id;
    this.base_adresses = [];
    this.image_adresses = [];

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
        // id by malo byt vzdy rovnake pre skupinu obrazkov
        var input = $(document).find('div.previews_ids').find('input#bg_images_id_'+(this.image_order-1));
        //console.log(input);
        this.images_id = parseInt(input.val());
        //console.log(this.images_id);
        var toto_image_adresses = this.image_adresses;
        var toto_addr_id_regex = this.addr_id_regex;
        var toto_images_id = this.images_id;
        this.base_adresses.forEach(function(item) {
            var url = item.replace(toto_addr_id_regex, "$1"+toto_images_id+"$3");
            toto_image_adresses.push(url);
        });
        //console.log(this.image_adresses);
    },

    isCurrent: function() {
        var tmp_addr = $(document).find('div.preview').children('figure').first().children('picture').children('img').attr('src');
        var id_of_visible = parseInt(tmp_addr.match(this.addr_id_regex)[2]);
        //console.log(id_of_visible);
        //console.log(this.images_id);
        return (id_of_visible === this.images_id);
    }

}