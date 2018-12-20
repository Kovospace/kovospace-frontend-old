
function Category() {
    this.postsOrdering;
    this.init();
}

Category.prototype = {
    constructor: Category,

    init: function() {
        this.postsOrdering = new orderItems();
    },

    onready: function() {
        this.postsOrdering.init();
    }
}
