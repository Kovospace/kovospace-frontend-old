(function($) {
     //'overflow': $(this).data('overflow-before'), // blolo vo false vetve predtym
    $.fn.hideScrollbars = function (sw) {

        return this.each(function() {
            var scrollbar_size = window.innerWidth - document.documentElement.clientWidth;
            if (sw === false) {
                //console.log($(this).data('overflow-before'));
                $(this).css({
                    'overflow': 'auto',
                    'margin-right': '0'
                });
            } else if (sw === true) {
                if ($(this).css('overflow').length == 0) {
                    $(this).data('overflow-before', 'auto');
                } else {
                    $(this).data('overflow-before', $(this).css('overflow'));
                    $(this).css({
                        'overflow':'hidden',
                        'margin-right':scrollbar_size+'px'
                    });
                }
            }
        });
    }
}(jQuery));