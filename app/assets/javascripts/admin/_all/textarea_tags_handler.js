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
        console.log(T.text.match(/<#obrazok(\d+)#>/g));
        var tags = T.text.match(/<#obrazok(\d+)#>/g);
        for (var i=0; i<tags.length; i++) {
            if (T.checkImageExistence(tags[i]) === true) {
                //console.log("aaano");
            } else {
                //console.log("nieeeeeeee");
                T.removeTag(tags[i]);
            }
        }
        //T.checkImageExistence(tag);
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
        var text = $('.trix-content').html();
        //console.log(text);
        //console.log(escapeHTML(tag));
        //console.log(text.replace(escapeHTML(tag), ""));
        $('.trix-content').html(text.replace(escapeHTML(tag), ""));
        //console.log(tag);
    },

    checkTagExistence: function(tag) {
        //console.log(tag);
        //console.log(this.text);
        //console.log(tag);
        //console.log(this.text.indexOf(tag) !== -1);
        //this.text = $('.trix-content').text()
        return (this.text.indexOf(tag) !== -1)
    },

    checkImageExistence: function(tag) {
        //console.log(T.text.match(/<#obrazok(\d+)#>/g));
        var tag_id = tag.match(/\d+/);
        //console.log(tag_id);
        var exists = false;
        $(document).find('input.identificator').each(function() {
            if ($(this).val() == tag_id) {
                exists = true;
                return false;
            } /*else {

            }*/
        });
        return exists;
    }

}
