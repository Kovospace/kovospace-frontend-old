function textAreaTagsHandler() {
    this.cursor_position = 0;
    this.text = "";
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
        T.text = $('.trix-content').text();
        //this.text = $('.trix-content').text();
        //console.log("changed");
        ref.children('picture:not(:last-child)').each(function() {
            var pic_num = $(this).children('input.identificator').val();
            var tag = T.TEMPLATE.image.tag(pic_num);
            //T.text = $('.trix-content').html();
            //var exists = T.checkTagExistence();
            if (T.checkTagExistence(tag) === true) {

            } else {
                T.insertTag(tag);
            }
        });
    },

    trackCursorPosition: function(ref) {
        //console.log("changed");
        this.cursor_position = this.HELPER.getCaretPosition(ref);
    },

    insertTag: function(tag) {
        //$('.trix-content').focus();
        //$('.trix-content').selectionStart = 3;
         //$('.trix-content').selectionEnd = 3;
        //document.getSelection().collapse($('.trix-content')[0], 0);
        //$('.trix-content')[0].setSelectionRange(0, 0);
        this.HELPER.setCaretPosition(document.getElementsByClassName('trix-content')[0], this.cursor_position);
        this.HELPER.insertContent(tag);
        //$('.trix-content')[0].setSelectionRange(pos, pos)
    },

    removeTag: function(tag) {
         T.text = $('.trix-content').text();
         console.log(T.text);
    },

    checkTagExistence(tag) {
        //console.log(tag);
        //console.log(this.text);
        //console.log(tag);
        //console.log(this.text.indexOf(tag) !== -1);
        //this.text = $('.trix-content').text()
        return (this.text.indexOf(tag) !== -1)
    }

}
