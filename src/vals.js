var isArray = function(arr) {
  return Object.prototype.toString.apply(arr) === '[object Array]';
};

module.exports = vals;
vals.one = val;

function vals(obj) {
  var paths = Array.prototype.slice.call(arguments, 1);
  var result = [];
  for (var i = 0; i < paths.length; i++) {
    result.push(val(obj, paths[i]));
  }
  return result;
}

function val(obj, path) {
  if (obj === undefined || obj === null) {
    return undefined;
  }
  if (!isArray(path)) {
    return obj[path];
  }
  var result = obj || undefined;
  for (var i = 0; i < path.length && result; i++) {
    result = result[path[i]];
  }
  return result;
}