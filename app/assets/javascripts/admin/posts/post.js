
function Post() {
    this.imagePreview;
    this.textAreaTagsHandler;
    this.init();
}

Post.prototype = {
    constructor: Post,

    init: function() {
        this.imagePreview = new imagePreview();
        this.textAreaTagsHandler = new textAreaTagsHandler();
    },

    onready: function() {
        this.imagePreview.init();
        this.textAreaTagsHandler.init();
    }
}
