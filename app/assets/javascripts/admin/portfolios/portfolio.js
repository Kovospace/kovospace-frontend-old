function Portfolio() {
    this.imagePreview;
    this.textAreaTagsHandler;
    this.init();
}

Portfolio.prototype = {
    constructor: Portfolio,

    init: function() {
        this.imagePreview = new imagePreview();
        this.textAreaTagsHandler = new textAreaTagsHandler();
    },

    onready: function() {
        this.imagePreview.init();
        this.textAreaTagsHandler.init();
    }
}