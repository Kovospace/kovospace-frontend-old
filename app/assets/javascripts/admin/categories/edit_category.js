
function CategoriesEdit() {
    this.postsOrdering;
    this.init();
}

CategoriesEdit.prototype = {
    constructor: CategoriesEdit,

    init: function() {
        this.postsOrdering = new orderPosts();
    },

    onready: function() {
        this.postsOrdering.init();
    }
}
