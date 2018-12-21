function textAreaTagsHandler() {
    this.cursor_position = 0;
    this.HELPER = new textAreaTagsHandlerHelper();
    this.TEMPLATE = textAreaTagsHandlerTemplates;
}

textAreaTagsHandler.prototype = {
    constructor: textAreaTagsHandler,

    init: function() {
        this.HELPER.init();
        var T = this;
        $(document).on('content_changed', 'div.pictures', function() {
            T.reactToChanges($(this));
        });
        $(document).on('keyup mouseup', '.trix-content', function() {
            T.trackCursorPosition(this);
        });
    },

    reactToChanges: function(ref) {
        var T = this;
        //console.log("changed");
        ref.children('picture:not(:last-child)').each(function() {
            var pic_num = $(this).children('input.identificator').val();
            T.checkTagExistence(T.TEMPLATE.image.tag(pic_num));
        });
    },

    trackCursorPosition: function(ref) {
        //console.log("changed");
        this.cursor_position = this.HELPER.getCaretPosition(ref);
    },

    insertTag: function(tag) {

    },

    removeTag: function(tag) {

    },

    checkTagExistence(tag) {
        //console.log(tag);
    }

}
