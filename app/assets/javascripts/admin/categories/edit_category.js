
function CategoriesEdit() {
    this.postsOrdering;
    this.init();
}

CategoriesEdit.prototype = {
    constructor: CategoriesEdit,

    init: function() {
        this.postsOrdering = new orderItems();
    },

    onready: function() {
        this.postsOrdering.init();
    }
}
