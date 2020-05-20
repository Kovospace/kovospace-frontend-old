function DynamicStylesFix() {
    this.controller;
    this.id;
}

DynamicStylesFix.prototype = {
    constructor: DynamicStylesFix,

    init: function() {
        this.controller = $(document).find('body').attr('class');
        this.id = parseInt($(document).find('input#'+this.controller+'_id').val());
        this.cleanup();
    },

    cleanup: function () {
        var totok = this;
        $(document).find('head').children('style').each(function() {
            var id = $(this).attr('id')
            if (id !== undefined) {
                var id = parseInt($(this).attr('id').replace(/\D+/, ''));
                if (totok.id !== id) { $(this).remove(); }
            }
        });
    }

}