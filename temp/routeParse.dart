// var forrrr = "/input/:id/:id2";
// RegExp exp = RegExp(r":\w+");
// var temp = forrrr.replaceAll(exp, "2");
//
var pathToRegex = (path) {
  RegExp exp = RegExp(r":\w+");
  RegExp exp2 = RegExp(r"\/");
  var temp = "^" + path.replaceAll(exp2, "\\/").replaceAll(exp, "(.+)") + r"$";
  return RegExp(temp);
};

var getParams = (match) {
  RegExp exp2 = RegExp(r":(\w+)");
  var values = match.result.slice(1);
  var keys =
      List.from(match.route.path.matchAll(exp2)).map((result) => result[1]);

  var l = keys.map((val) {
    var i = values.indexOf(val);
    return [val, values[i]];
  });
  // return Map.fromEntries(l);
};
// RegExp exp2 = RegExp(r"(.+)");
// RegExp exp = RegExp(r":\w+");
main(List<String> args) {
  var fortest = "/input/66/55";
  var forrrr = "/input/:id/:id2";
  var reg = pathToRegex(forrrr);
  // var temp = fortest.replaceAllMapped(forrrr, (match) => null);
  var temp = fortest.replaceAll(reg, forrrr);

  // var matches = exp.allMatches(forrrr);
  // matches.forEach((key) {
  //   var substr = forrrr.substring(key.start, key.end);
  //   print(substr);
  // });
  // var fortest = "/input/66/55";
  // var substr = tmp.substring(key.start, key.end);

  // var temp = fortest.toString().split("/");
  // temp.removeAt(0);
  print(temp);
}
