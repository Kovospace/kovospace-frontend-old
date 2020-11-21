$.fn.isBound = function (type) {
    var data = $._data($(this)[0], 'events');

    if (data[type] === undefined || data.length === 0) {
        return false;
    }
    return true;
};