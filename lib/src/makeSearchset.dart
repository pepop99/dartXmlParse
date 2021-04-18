import 'dart:async';
import 'dart:io';


Future<List<FileSystemEntity>> readCorpus(Directory dir) {
  var files = <FileSystemEntity>[];
  var completer = Completer<List<FileSystemEntity>>();
  var lister = dir.list(recursive: false);
  lister.listen ( 
      (file) => files.add(file),
      onDone:   () => completer.complete(files)
      );
  return completer.future;
}

Future<String> readLicense(String fileName) async => await File(fileName).readAsString().then((String contents) {
  return (contents);
  });
void main() async{
  var dir = Directory('../v2Corpus');
  var licenses = await readCorpus(dir);
  print(licenses[0].uri);
  for (var license in licenses) {
    print(await readLicense(license.path));
  }
}