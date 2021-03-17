import 'dart:io';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void getTarBallLink() async{
  var headers = {
    'Accept': 'application/vnd.pub.v2+json'
  };
  var request = http.Request('GET', Uri.parse('https://pub.dartlang.org/api/packages/location'));
  
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
  final tarGz = GZipEncoder().encode(tar_data);
  final fp = File('test.tar.gz');
  fp.writeAsBytesSync(tarGz);
}
void main() {
  getTarBallLink();
}