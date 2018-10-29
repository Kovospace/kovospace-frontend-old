function orderPosts() {
    //this.init();
}

orderPosts.prototype = {
    constructor: orderPosts,

    init: function() {
        var T = this;
        $(document).on("click", "td.up", function() {
            T.move_up($(this));
            T.renumber_indexes($(this).closest('tbody'));
        });
        /*$(document).on("click", "td.down", function() {
            T.move_down($(this));
        });*/
    },

    move_up: function(ref) {
        var prev_id = ref.closest('tr').prev().attr('id');
        console.log(prev_id);
        //console.log($('tr#article_'+curr_id));
        ref.closest('tr').insertBefore('tr#'+prev_id);
    },

    move_down: function(ref) {
        var prev_id = ref.closest('tr').prev().attr('id');
        console.log(prev_id);
        //console.log($('tr#article_'+curr_id));
        ref.closest('tr').insertBefore('tr#'+prev_id);
    },

    renumber_indexes: function(ref) {
        ref.children('tr').each(function(index) {
            console.log(index);
            var input_attr = $(this).children("input").attr("name");
            //input_attr
            console.log(input_attr);
        });
    }

}
