function BlogsEdit() {
    this.categoriesOrdering;
    this.init();
}

BlogsEdit.prototype = {
    constructor: BlogsEdit,

    init: function() {
        this.categoriesOrdering = new orderCategories();
    },

    onready: function() {
        this.categoriesOrdering.init();
    }
}
