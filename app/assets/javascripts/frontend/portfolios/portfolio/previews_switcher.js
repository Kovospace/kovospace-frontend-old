function PreviewsSwitcher() {
    this.previews = [];
    this.current_id;
    this.current_order;
}

PreviewsSwitcher.prototype = {
    constructor: PreviewsSwitcher,

    init: function() {
        this.getImageUrls();
    },

    getImageUrls: function() {
        var toto_previews = this.previews;
        var toto_current_id = this.current_id;
        var toto_current_order = this.current_order;
        $(document).find('ul.preview_switcher').children('li').each(function() {
            var num = parseInt($(this).children('a').children('span').children('em').text());
            var preview = new Preview(num);
            toto_previews.push(preview);
            //console.log(preview.isCurrent());
            if (preview.isCurrent() === true) {
                toto_current_id = preview.images_id;
                toto_current_order = num;
            }
        });
    }
}