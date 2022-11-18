function Homepage() {
    this.init();
}

Homepage.prototype = {
    constructor: Homepage,

    init: function() {
    },

    onready: function() {
        
    },

    onload: function() {

    },

    once: function() {

    },

    onturbolinks: function() {
        var toto = this;
        $(document).on('click', '#work_experiences_show_more', function(e) {
            e.preventDefault();
            $(document).find("#work_experiences_table").toggleClass("visible");
            $(document).find("#work_experiences_show_more").toggleClass("visible");
        });
    }
}