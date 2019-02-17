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
        console.log(caretOffset);
        return caretOffset;
    },

    setCaretPosition: function(element, position) {
        element.focus();
        console.log("element: ", element);

        function setPosition(el, pos) {
            for(var node of el.childNodes){
                if(node.nodeType == 3){ // we have a text node
                    if(node.length >= pos){
                        // finally add our range
                        var range = document.createRange(),
                            sel = window.getSelection();
                        range.setStart(node,pos);
                        range.collapse(true);
                        sel.removeAllRanges();
                        sel.addRange(range);
                        return -1; // we are done
                    }else{
                        pos -= node.length;
                    }
                }else{
                    pos = setPosition(node,pos);
                    if(pos == -1){
                        return -1; // no need to finish the for loop
                    }
                }
            }
            return pos; // needed because of recursion stuff
        }

        setPosition(element, position);
    },

    insertContent: function(content) {
        var sel, range;
        if (this.w3) {
            // IE9 and non-IE
            sel = window.getSelection();
            if (sel.getRangeAt && sel.rangeCount) {

                //window.getSelection().collapse(document.getElementsByClassName('trix-content')[0].firstChild, 0);

                range = sel.getRangeAt(0);
                range.deleteContents();

                var el = document.createElement("div");
                el.innerHTML = content;
                var frag = document.createDocumentFragment(), node, lastNode;
                while ( (node = el.firstChild) ) {
                    lastNode = frag.appendChild(node);
                }
                range.insertNode(frag);

                if (lastNode) {
                    range = range.cloneRange();
                    range.setStartAfter(lastNode);
                    range.collapse(true);
                    sel.removeAllRanges();
                    sel.addRange(range);
                }
            }
        } else if (this.ie) {
            document.selection.createRange().pasteHTML(content);
        }
    }



}
