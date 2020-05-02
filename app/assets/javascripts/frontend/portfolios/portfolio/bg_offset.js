function BgOffset() {
    this.init();
}

BgOffset.prototype = {
    constructor: BgOffset,

    init: function() {

    },

    offset: function() {
        var orig_elem_h = $(document)
            .find('nav.show_work > ul:not(.preview_switcher)')
            .find('a.fakehover.active').height();
        var nav = $(document).find('nav.show_work');
        var nav_padding = nav.outerHeight() - nav.height();
        $(document)
            .find('div.preview.responsive > div.bgs > figure')
            .css({ 'margin-bottom': (orig_elem_h+nav_padding)/2+'px' });
    }

}
