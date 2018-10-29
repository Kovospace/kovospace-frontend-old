function Router() {

}

Router.prototype = {
    constructor: Router,

    load: function() {
        var controller_string = $("body").attr("class").replace(/^admin\s*/, "").replace(/\s+/, "_");
        return (new window[controller_string.classycase()]());
    }
}
