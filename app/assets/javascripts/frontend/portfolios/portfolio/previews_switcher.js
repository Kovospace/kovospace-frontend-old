function PreviewsSwitcher() {
    this.previews = [];
    this.load_direction = +1;
    this.current_index = 0;
    this.next_index = 0;
    this.prev_index = null;

    this.current_id;
    this.current_order;
}

PreviewsSwitcher.prototype = {
    constructor: PreviewsSwitcher,

    init: function() {
        this.getImageUrls();
        this.setNext();
        this.assignActions();
    },

    assignActions: function() {
        var toto = this;
        $(document).on('click', 'ul.preview_switcher li', function(e) {
            e.preventDefault();
            var order = parseInt($(this).children('a').children('span').children('em').text());
            toto.show(order);
            //console.log('clicked');
            //toto.skipTo(order);
        });
    },

    getImageUrls: function() {
        var toto = this;
        var index = 0;
        $(document).find('ul.preview_switcher').children('li').each(function() {
            var num = parseInt($(this).children('a').children('span').children('em').text());
            var preview = new Preview(num);
            toto.previews.push(preview);
            //console.log(preview.isCurrent());
            if (preview.isCurrent() === true) {
                toto.current_id = preview.images_id;
                toto.current_order = num;
                toto.current_index = index;
            }
            index++;
        });
        //console.log(this.previews);
    },

    setIndex: function(index) {
        if (this.prev_index === null) {
            this.prev_index = 0;
        } else {
            this.prev_index = this.current_index;
        }
        //console.log(this.prev_index);
        if (index !== undefined) {
            //console.log("set index");
            this.current_index = this.validIndex(index);
        }
    },

    setNext: function() {
        // next ako dalsi na preload
        this.next_index = this.current_index+this.load_direction;
        if (this.next_index > this.previews.length-1) {
            this.next_index = 0;
        } else if (this.next_index < 0) {
            this.next_index = this.previews.length-1;
        }
    },

    decideLoadDirection: function() {
        if (this.prev_index < this.current_index) {
            this.load_direction = +1;
        } else if (this.prev_index > this.current_index) {
            this.load_direction = -1;
        }
        // ak sa rovna, bez zmeny, tj posledne pouzite
    },

    validIndex: function(index) {
        var last = this.previews.length-1;
        if (index > last) { return 0; }
        else if (index < 0) { return last; }
        else { return 0; }
    },

    show: function(order) {
        var toto = this;
        var index = 0;
        //console.log(this.previews);
        this.previews.forEach(function(item) {
            //console.log(item.image_order);
            if (item.image_order === order) {
                console.log(item.image_order);
                console.log(order);
                //item.render();
                toto.skipTo(index);
            }
            index++;
        });
    },

    prev: function() {
        this.skipTo(this.current_index-1);
    },

    next: function() {
        this.skipTo(this.current_index+1);
    },

    skipTo: function(index) {
        //console.log(index);
        //console.log(this.previews);
        //console.log(this.prev_index);
        this.setIndex(index);
        console.log(this.current_index);
        this.decideLoadDirection();
        //console.log(this.load_direction);
        this.setNext();
        //console.log(this.previews.length);
        //console.log(this.next_index); // chyba
        //this.previews[this.current_index].render();
        //this.previews[this.next_index].preload();
        //console.log(this.current_index);
        //console.log(this.next_index);
        //this.previews[1].preload();
        //this.previews[0].preload();
        //this.previews[this.next_index].render();
        //this.previews[this.current_index].preload();
        this.previews[this.next_index].preload();
        //this.previews[this.current_index].render();
        //this.previews[this.next_index].preload();
        console.log(this.previews);
        var toto = this;
        setTimeout(function(){ console.log(toto.previews); }, 3000);
    }
}