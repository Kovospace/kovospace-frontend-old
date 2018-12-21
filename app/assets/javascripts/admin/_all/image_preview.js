function imagePreview() {
    this.newImageClone;
}

imagePreview.prototype = {
    constructor: imagePreview,

    init: function() {
        var T = this;
        T.newImageClone = $('div.pictures').children('picture').last().clone();
        $(document).on('change', 'input[type=file]', function() {
            T.readUrl(this);
            //console.log('changed');
        });
    },

    readUrl: function(input) {
        var T = this;

        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                T.cloneNewImageButton();

                //console.log('reader load');
                //$('#blah').attr('src', e.target.result);
                //if (e.target.result === undefined) {
                    //console.log('kokot');
                //}
                //console.log(e.target);

            }
            reader.readAsDataURL(input.files[0]);
        }
    },

    appendPreview: function(ref) {
        // odstranit plus a vlozit img tag
    },

    cloneNewImageButton: function() {
        // dorobit - ale len ak bol navoleny novy obrazok
        // pridava aj ked bol zmeneny existujuci
        var some_empty = false
        var next_index = 0;
        $('div.pictures').children('picture').each(function() {
            var index = parseInt($(this).find('input[type=file]').attr('name').match(/\d+/));
            if (index > next_index) { next_index = index; }
            //console.log($(this).find('input[type=file]').attr('name').match(/\d+/));

            //if ($(this).find('img')) {

            //}
        });
        next_index++;

        var tmp_obj = this.newImageClone.clone();
        tmp_obj.children('input').each(function() {
            var new_name = $(this).attr('name').replace(/\d+/, next_index);
            var new_id = $(this).attr('id').replace(/\d+/, next_index);
            $(this).attr('name', new_name);
            $(this).attr('id', new_id);
        });
        var label_name = $(tmp_obj).children('span').children('label').attr('for').replace(/\d+/, next_index);
        //console.log(label_name);
        $(tmp_obj).children('span').children('label').attr('for', label_name)
        tmp_obj.appendTo('div.pictures');

    }




}
