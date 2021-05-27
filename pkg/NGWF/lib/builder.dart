import 'package:build/build.dart';

/// A really simple [Builder], it just makes copies of .txt files!
class HTMLCSSBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.html': ['.dart'],
    '.css': ['.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Each `buildStep` has a single input.
    var inputId = buildStep.inputId;
    var ext = inputId.path.toString().split('.').last;
    var ext2 = inputId.path.toString().split('/').last;
    var variable = ext2
                      .toString()
                      .split('.')
                      .toList()
                      .where((f) => f != ext)
                      .map((e) => e[0].toUpperCase() + e.substring(1))
                      .join('');
    

    // Create a new target `AssetId` based on the old one.
    var copy = inputId.changeExtension('.dart');
    // AssetId copy = inputId.changeExtension('').changeExtension('.dart');
    var contents = await buildStep.readAsString(inputId);
    var newcontent = """String $variable = '''\n$contents\n''';""";
    print(copy);

    // // Write out the new asset.
    // await buildStep.writeAsString(copy, contents);
    await buildStep.writeAsString(copy, newcontent);
  }
}

Builder htmlcssBuilder(BuilderOptions options) => HTMLCSSBuilder();
