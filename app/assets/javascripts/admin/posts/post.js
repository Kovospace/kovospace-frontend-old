
function Post() {
    this.imagePreview;
    this.init();
}

Post.prototype = {
    constructor: Post,

    init: function() {
        this.imagePreview = new imagePreview();
    },

    onready: function() {
        this.imagePreview.init();
    }
}
