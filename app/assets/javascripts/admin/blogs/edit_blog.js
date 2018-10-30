function BlogsEdit() {
    this.categoriesOrdering;
    this.init();
}

BlogsEdit.prototype = {
    constructor: BlogsEdit,

    init: function() {
        this.categoriesOrdering = new orderItems();
    },

    onready: function() {
        this.categoriesOrdering.init();
    }
}
