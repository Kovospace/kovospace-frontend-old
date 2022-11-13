function PreviewsSwitcher() {
    this.previews;
    this.load_direction;
    this.current_index;
    this.next_index;
    this.prev_index;
    this.cycle_time;
    this.current_id;
    this.current_order;
    this.poll;
    this.cycler;
    this.continue;
}

PreviewsSwitcher.prototype = {
    constructor: PreviewsSwitcher,

    init: function() {
        this.setVars();
        this.getImageUrls();
        if (this.continue === true) {
            this.setNext();
            this.assignActions();
            this.firstTimeLoad();
            this.cycle();
        }
    },

    setVars: function() {
        this.continue = false;
        this.previews = [];
        this.load_direction = +1;
        this.current_index = 0;
        this.next_index = 0;
        this.prev_index = null;
        this.cycle_time = 4000;
        this.current_id = null;
        this.current_order = null;
        clearTimeout(this.cycler);
        clearInterval(this.poll);
    },

    assignActions: function() {
        var toto = this;
        $(document).on('click', 'ul.preview_switcher li', function(e) {
            e.preventDefault();
            toto.stopCycling();
            var order = parseInt($(this).children('a').children('span').children('em').text());
            toto.show(order);
        });
    },

    getImageUrls: function() {
        var toto = this;
        var index = 0;
        $(document).find('ul.preview_switcher').children('li').each(function() {
            var num = parseInt($(this).children('a').children('span').children('em').text());
            var preview = new Preview(num);
            toto.previews.push(preview);
            if (preview.isCurrent() === true) {
                console.log("is current");
                toto.current_id = preview.images_id;
                toto.current_order = num;
                toto.current_index = index;
            }
            index++;
        });
        if (index > 0) {
            this.continue = true;
        }
    },

    setIndex: function(index) {
        if (this.prev_index === null) {
            this.prev_index = 0;
        } else {
            this.prev_index = this.current_index;
        }
        if (index !== undefined) {
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
        else { return index; }
    },

    show: function(order) {
        var toto = this;
        var index = 0;
        this.previews.forEach(function(item) {
            if (item.image_order === order) {
                if (item.isCurrent() === true) {
                } else {
                    toto.skipTo(index);
                }
            }
            index++;
        });
    },

    firstTimeLoad: function() {
        this.setIndex(0);
        this.setNext();
        this.previews[this.next_index].preload();
    },

    prev: function() {
        this.skipTo(this.current_index-1);
    },

    next: function() {
        this.skipTo(this.current_index+1);
    },

    skipTo: function(index) {
        var toto = this;
        console.log(index);
        this.setIndex(index);
        this.decideLoadDirection();
        this.setNext();
        this.previews[this.current_index].render();
        this.poll = setInterval(function(){
            if (toto.previews[toto.current_index].all_preloaded === true) {
                clearInterval(toto.poll);
                toto.previews[toto.next_index].preload();
            }
        }, 100);
    },

    cycle: function() {
        // mozno implementovat obmedzenie na nejaky pocet cyklov
        var toto = this;
        this.cycler = setTimeout(function() {
            if (toto.previews[toto.next_index].all_preloaded == true) {
                toto.next();
            }
            toto.cycle();
        }, toto.cycle_time);
    },

    stopCycling: function() {
        clearTimeout(this.cycler);
    }
}