function orderItems() {

}

orderItems.prototype = {
    constructor: orderItems,

    init: function() {
        var T = this;
        $(document).on("click", "td.up", function() {
            T.move_up($(this));
            T.renumber_indexes($(this).closest('tbody'));
        });
        $(document).on("click", "td.down", function() {
            T.move_down($(this));
            T.renumber_indexes($(this).closest('tbody'));
        });
    },

    move_up: function(ref) {
        var prev_id = ref.closest('tr').prev().attr('id');
        ref.closest('tr').insertBefore('tr#'+prev_id);
    },

    move_down: function(ref) {
        var next_id = ref.closest('tr').next().attr('id');
        ref.closest('tr').insertAfter('tr#'+next_id);
    },

    renumber_indexes: function(ref) {
        ref.children('tr').each(function(index) {
            var input_attr = $(this).children("input").attr("name");
            $(this).children("input").attr("name", input_attr.replace(/(\d+)/, index));
        });
    }

}
