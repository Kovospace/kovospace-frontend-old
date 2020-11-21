function Router() {

}

Router.prototype = {
    constructor: Router,

    load: function() {
        var controller_string = $("body").attr("class");
        if ((fx = window[controller_string.classycase()]) !== undefined) {
            return (new fx());
        }
    },

    getControllerName: function() {
    	return $("body").attr("class");
    }
}
