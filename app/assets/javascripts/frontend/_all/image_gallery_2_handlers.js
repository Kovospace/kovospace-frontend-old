function ImageGallery2Handlers() {
    
}

ImageGallery2Handlers.prototype = {
    constructor: ImageGallery2Handlers,

    handle: function(ref) {

        if (ref.SETTINGS.images_container !== null) {
            // pozreet ci null ak jquery nenajde
            $(ref.SETTINGS.images_container).on('click', 'picture', function(e) {
                ref.open(e.target);
            });
        }

        // kliknutie inde ako na ine aktivne tlacidlo
        $(document).on('click', 'div.gallery', function() {
            ref.close();
        });

        // sipka vlavo
        $(document).on('click', 'div.body > span.left', function(e) {
            ref.prev();
            ref.HELPER.stopEvents(e);
        });

        // sipka vpravo
        $(document).on('click', 'div.body > span.right', function(e) {
            ref.next();
            ref.HELPER.stopEvents(e);
        });

        // klik na nahlad
        $(document).on('click', 'div.gallery > div.switcher > picture', function(e) {
            var id = ref.HELPER.getIdFromUrl($(this).children('img').attr('src'));
            ref.show(id);
            ref.HELPER.stopEvents(e);
        });

        // scrollovanie nahladov sipkami
        $(document).on('mousedown', 'div.gallery > div.switcher > span > p', function(e) {
            //console.log('sclolovat by malo');
            ref.HELPER.scrollWithArrows(ref, $(this));
            ref.HELPER.stopEvents(e);
        }).on('mouseup', 'div.gallery > div.switcher > span > p', function(e) {
            clearInterval(ref.HELPER.timer);
            ref.HELPER.stopEvents(e);
        });

        // schovat sipku ak na zaciatku/konci
        $(document).find('div.switcher').on('scroll', function() {
            ref.HELPER.hideArrowsBasedOnScroll($(this));
        });

        // scroll po zajdeni vybratej polozky za okraj
        $(document).on('change', 'div.switcher', function(e) {
            ref.HELPER.alignScrollbar($(this));
            ref.HELPER.stopEvents(e);
        });

        // klik na pas nahladov - proti zavretiu galerie
        $(document).on('click', 'div.gallery > div.switcher', function(e) {
            ref.HELPER.stopEvents(e);
        });

        // klik na obrazok - zabranit zavretiu
        $(document).on('click', 'div.body > picture > img', function(e) {
            ref.HELPER.stopEvents(e);
        });

    }
}