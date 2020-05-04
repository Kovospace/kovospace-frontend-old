function imagePreview() {
    this.newImageClone;
    this.container = 'div.gallery > div.pictures';
    this.next_index = 0;
}

imagePreview.prototype = {
    constructor: imagePreview,

    init: function() {
        var T = this;
        T.newImageClone = $(T.container).children('picture').last().clone();
        //$(document).on('change', 'input[type=file]', function() {
        $(document).on('change', this.container+'> picture > input[type=file]', function() {
            T.readUrl(this);
        });
        $(document).on('click', 'label.destroy.new', function() {
            T.removeNewlyAddedImage($(this));
        });
    },

    readUrl: function(input) {
        var T = this;
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                if ($(input).parent().hasClass('loaded')) {
                    // uprava obrazka
                } else {
                    // novy obrazok
                    T.cloneNewImageButton(T);
                }
                //console.log($(input).parent());
                //T.cloneNewImageButton(T);
                T.appendPreview($(input), e.target.result);
                //console.log('onload koniec');
                T.triggerChange();
            }
            reader.readAsDataURL(input.files[0]);
        }
    },

    appendPreview: function(ref, src) {
        var lbl = ref.siblings('span').children('label')
        var i = ref.siblings('input.identificator').val();
        lbl.empty();
        lbl.append('<img>');
        lbl.children('img').attr('src', src);
        //console.log(ref.parent());
        if (ref.parent().hasClass('loaded')) {
            // zmena obrazka
        } else {
            // pridanie noveho
            ref.parent()
                .append('<em>'+i+'</em>')
                .append('<label class="destroy new">X</label>')
                .addClass('loaded');
        }
        /*ref.parent()
            .append('<em>'+i+'</em>')
            .append('<label class="destroy new">X</label>');*/
    },

    cloneNewImageButton: function(ref) {
        var some_empty = false
        var next_index = 0;

        //$(this.container).children('picture').each(function() {
        //console.log(this.container);
        $(ref.container).children('picture').each(function() {
            //var index = parseInt($(this).find('input[type=file]').attr('name').match(/\d+/));
            var index = parseInt($(this).find('input.identificator').val());
            //if (index > next_index) { next_index = index; }
            if (index > ref.next_index) { ref.next_index = index; }
        });
        ref.next_index++;
        var tmp_obj = ref.newImageClone.clone();
        //console.log('next index: ' + ref.next_index);
        //var tmp_obj = ref.newImageClone.clone();

        tmp_obj.children('input').each(function() {
            // pre file input pole,
            // cache pole
            // ID pole
            var new_name = $(this).attr('name').replace(/\d+/, ref.next_index);
            var new_id = $(this).attr('id').replace(/\d+/, ref.next_index);
            $(this).attr('name', new_name);
            $(this).attr('id', new_id);
        });
        // identifikator poradia
        tmp_obj.children('input.identificator').val(ref.next_index);
        // label, ktorou je zaobaleny obrazok
        var label_name = tmp_obj.children('span').children('label').attr('for').replace(/\d+/, ref.next_index);
        tmp_obj.children('span').children('label').attr('for', label_name)
        // textarea pri obrazku na popis
        var textarea = tmp_obj.children('span').children('textarea');
        var textarea_name = textarea.attr('name').replace(/\d+/, ref.next_index);
        var textarea_id = textarea.attr('id').replace(/\d+/, ref.next_index);
        textarea.attr('name', textarea_name);
        textarea.attr('id', textarea_id);


        //tmp_obj.appendTo('div.pictures');
        //console.log('attr name: ')
        //console.log(tmp_obj.children('input'));
        //console.log('id name: ' + tmp_obj.attr('id'));
        //console.log('label for: ' + tmp_obj.children('span').children('label').attr('for'));

        tmp_obj.appendTo($(ref.container));
    },

    removeNewlyAddedImage: function(ref) {
        var trg = ref.closest('div.pictures');
        ref.closest('picture').remove();
        trg.trigger('content_changed');
    },

    triggerChange: function() {
        console.log('change triggered');
        $(this.container).trigger('content_changed');
    }

}
