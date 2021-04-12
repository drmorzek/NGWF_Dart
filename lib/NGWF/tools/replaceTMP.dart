library replaceTMP;

// void main(List<String> args) {
//   const str =
//       " the {{  quick }} brown {{fox}} {{jumps}} over {{ lazy | test | multi: второй аргумент }} dog";
//   const str2 =
//       " the Ssss brown 4 rrr over 1 test второй аргумент dog";

//   var data = {"quick": "Ssss", "fox": 4, "lazy": 1, "jumps": "rrr"};

//   var funcs = {
//     "multi": (ctx, arg) {
//       // if (arg == null ) arg = "5";
//       return ctx.toString() + (arg ?? "");
//     },
//     "test": (ctx, arg) {
//       // if (arg == null ) arg = "5";
//       return ctx.toString() + " test";
//     }
//   };

//   print(replaceTMP(tmp: str, data: data, pipe: funcs));
//   print(replaceTMP(tmp: str2, data: data, pipe: funcs));
// }

String replaceTMP({String tmp = '', Map<String, dynamic> data , Map pipe}) {
  if (tmp == '' || data == null) return tmp;
  RegExp exp = RegExp(r"{{(.*?)}}");
  var matches = exp.allMatches(tmp);
  if (matches.isEmpty) return tmp;
  var newstr = tmp;
  matches.forEach((key) {
    var substr = tmp.substring(key.start, key.end);
    var findfuncs = substr
        .replaceAll("{{", "")
        .replaceAll("}}", "")
        .trim()
        .split('|')
        .map((e) => e.toString().trim())
        .toList();
    var findkey = findfuncs.removeAt(0);

    if (data != null && data[findkey] != null) {
      if (pipe != null) {
        findfuncs.forEach((findfunc) {
          var findargsfunc = findfunc.split(":");
          var func = findargsfunc.removeAt(0);

          if (pipe[func] != null) {
            if (findargsfunc.isEmpty) {
              data[findkey] = pipe[func](data[findkey], null);
            } else {
              findargsfunc.forEach((arg) {
                data[findkey] = pipe[func](data[findkey], arg);
              });
            }
          }
        });
      }
      newstr = newstr.replaceAll(substr, data[findkey].toString());
    }
  });
  return newstr;
}
