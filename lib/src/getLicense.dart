import 'dart:convert';
import 'package:http/http.dart' as http;
import 'normalize.dart';
import 'parseXml.dart';

void getLicense() async{
  //url is being for testing purposes only, later a tar file will be used which will be searched for LICENSE file
  var url = Uri.parse('https://raw.githubusercontent.com/spdx/license-list-XML/master/src/BSD-2-Clause-FreeBSD.xml');
  var request = http.Request('GET', url);
  
  var response = await request.send();
  
  if (response.statusCode == 200) {
    //code to store the streamed response as a string
    var responseString = '';
    await for (var bytes in response.stream.transform(Utf8Decoder())){
      responseString += bytes;
    }
    
    var xmlString = responseString;
    //initializing the parser
    var parser = xmlParser(xmlString);

    var licenseName = parser.parse('name');
    var licenseId = parser.parse('licenseId');
    var licenseBody = parser.extractText();
    
    print('License Name: $licenseName');
    print('License SPDX identifier: $licenseId');
    print('Stripped down text: $licenseBody');

    // The normalizer will normalize the parsed string according to SPDX guidlines
    var normalizer = Normalizer();
    var normalizedLicense = normalizer.normalize(licenseBody);
    print('Normalized License Text: $normalizedLicense');
  }
  else {
    print(response.reasonPhrase);
  }
}
void main() {
  getLicense();
}
