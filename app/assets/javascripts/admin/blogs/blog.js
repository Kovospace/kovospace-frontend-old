function Blog() {
    this.categoriesOrdering;
    this.init();
}

Blog.prototype = {
    constructor: Blog,

    init: function() {
        this.categoriesOrdering = new orderItems();
    },

    onready: function() {
        this.categoriesOrdering.init();
    }
}
