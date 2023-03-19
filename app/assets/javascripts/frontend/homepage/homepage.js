function Homepage() {
    this.init();
    this.DEBOUNCE_TIME = 500; //miliseconds
    this.timer;
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
        var timer;
        var windowX;
        var windowY;

        // work experiences section folding and unfolding
        $(document).on('click', '#work_experiences_show_more', function(e) {
            e.preventDefault();
            $(document).find("#work_experiences_table").toggleClass("visible");
            $(document).find("#work_experiences_show_more").toggleClass("visible");
        });


        // tooltips for skills sections - programming language
        $(document).on('mouseenter', '#skills > article > div.description > figure', function(e) {
            toto.tooltip(e, $(e.target).closest('article').find('input.skillDescription').get(0).value);
        });

        // tooltips for skills sections - project
        $(document).on('mouseenter', '#skills > article > div.projects > a', function(e) {
            toto.tooltip(e, $(e.target).closest('a').find('input.projectDescription').get(0).value);
        });

    },

    tooltip: function(e, text) {
        clearTimeout(this.timer);    
        this.timer = setTimeout(function() {

            var windowWidth = $(window).width();

            $('#skills > div.tooltip').css({
                top: e.pageY + 'px',
                left: e.pageX + 'px',
                display: 'inline-block'
            });

            $('#skills > div.tooltip > div.wrap > span').text(text);

            if (e.pageX > (windowWidth/2)) {
                $('#skills > div.tooltip > div.wrap').addClass('right').removeClass('left');
                $('#skills > div.tooltip > div.wrap > span').addClass('right').removeClass('left');
            } else {
                $('#skills > div.tooltip > div.wrap').addClass('left').removeClass('right');
                $('#skills > div.tooltip > div.wrap > span').addClass('left').removeClass('right');
            }

        }, this.DEBOUNCE_TIME);
    }

}