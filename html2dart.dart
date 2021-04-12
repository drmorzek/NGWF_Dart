import 'dart:io';

var template = (name, text) => 'var $name = """\n$text\n""";';
main(List<String> args) async {
  Directory dir = Directory('web/app');
// execute an action on each entry
  dir.list(recursive: true).forEach((f) async {
    if (f is File) {
      // переименование расширения тест
      // var filearr = f.path.toString().split('.');
      // print(filearr);
      // filearr.last = "html";
      // print(filearr.join("."));
      // f.rename(filearr.join("."));
      //
      // чтение тест
      var filecontent = await f.readAsString();
      // print(file);
      //
      // print(f.uri.toString().split("/").last.split("."));
      var completePath = f.path;
      var fileName = (completePath
          .split('\\')
          .map((e) => e.split("/"))
          .reduce((value, element) => [...value, ...element])
          .last);
      var filePath = completePath
          .replaceAll("/$fileName", '')
          .replaceAll("\\$fileName", '');
      var fileNameArr = fileName.split('.');
      var ext = fileNameArr.removeLast();
      if (ext == "html") {
        // ext = ext == "html" ? "dart"
        var oldfileName = fileNameArr.join(".") + ".$ext";
        var oldfilePath = filePath + "/$fileName";
        ext = "dart";
        var newfileName = fileNameArr.join(".") + ".$ext";
        ;
        var newfilePath = filePath + "/$newfileName";
        print("$oldfilePath => $newfilePath");
        var newfile = File(newfilePath);
        if (await newfile.exists()) {
          await newfile.delete();
        }
        await newfile.writeAsString(template(fileNameArr.join(), filecontent));
      }

    }
  });
}
