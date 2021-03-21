import 'dart:io';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void getTarBall(String packageName) async{
  var headers = {
    'Accept': 'application/vnd.pub.v2+json'
  };
  var request = http.Request('GET', Uri.parse('https://pub.dartlang.org/api/packages/$packageName'));
  
  request.headers.addAll(headers);
  
  var response = await request.send();

  var responseString;
  if (response.statusCode == 200) {
    responseString = await response.stream.bytesToString();
  }
  else {
    print(response.reasonPhrase);
  }
  var responseObject = json.decode(responseString);
  var archiveUrl = Uri.parse(responseObject['latest']['archive_url']);

  var requestTar = http.Request('GET', archiveUrl);

  var requestTarResponse = await requestTar.send();
  
  var tar_data;
  if(requestTarResponse.statusCode == 200){
    tar_data = await requestTarResponse.stream.toBytes();
  }
  final archive = GZipDecoder().decodeBytes(tar_data);
  final archive1 = TarDecoder().decodeBytes(archive);
  for (final file in archive1) {
    final filename = file.name;

    //replace with regex to identify LICENSE file
    if (file.isFile && filename == 'LICENSE') {
      final data = file.content as List<int>;
      File('out/' + filename)
        ..createSync(recursive: true)
        ..writeAsBytesSync(data);
    } 
    // else {
    //   await Directory('out/' + filename)
    //     .create(recursive: true);
    // }
  }

  //code to save tarball to disk
  final tarGz = GZipEncoder().encode(tar_data);
  final fp = File('$packageName.tar.gz');
  fp.writeAsBytesSync(tarGz);
}
void main(List<String> arguments) async{
  if(arguments.isEmpty){
    print('invalid');
    exit(1);
  }
  getTarBall(arguments[0]);
}