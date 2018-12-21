function textAreaTagsHandlerHelper() {
    this.cursor_position = 0;
    this.ie;
    this.w3;
}

textAreaTagsHandlerHelper.prototype = {
    constructor: textAreaTagsHandlerHelper,

    init: function() {
        this.determineBrowser();
    },

    determineBrowser: function() {
        this.ie = (typeof document.selection != "undefined" && document.selection.type != "Control") && true;
        this.w3 = (typeof window.getSelection != "undefined") && true;
    },

    getCaretPosition: function(element) {
        var caretOffset = 0;
        if (this.w3) {
            var range = window.getSelection().getRangeAt(0);
            var preCaretRange = range.cloneRange();
            preCaretRange.selectNodeContents(element);
            preCaretRange.setEnd(range.endContainer, range.endOffset);
            caretOffset = preCaretRange.toString().length;
        } else if (this.ie) {
            var textRange = document.selection.createRange();
            var preCaretTextRange = document.body.createTextRange();
            preCaretTextRange.moveToElementText(element);
            preCaretTextRange.setEndPoint("EndToEnd", textRange);
            caretOffset = preCaretTextRange.text.length;
        }
        //console.log("offset " + caretOffset);
        return caretOffset;
    }



}
