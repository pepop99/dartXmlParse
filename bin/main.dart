import 'dart:convert';
import 'package:http/http.dart' as http;
import 'normalize.dart';
import 'package:xml/xml.dart';

import 'parseXml.dart';

void parseLisence() async{
  //url is being for testing purposes only, later a tar file will be used which will be searched for LICENSE file
  var url = Uri.parse('https://raw.githubusercontent.com/spdx/license-list-XML/master/src/MIT-Modern-Variant.xml');
  var request = http.Request('GET', url);
  
  var response = await request.send();
  
  if (response.statusCode == 200) {
    //code to store the streamed response as a string
    var responseString = '';
    await for (var bytes in response.stream.transform(Utf8Decoder())){
      responseString += bytes;
    }

    var xmlDoc = XmlDocument.parse(responseString);

    //parse the response string
    var parser = xmlParser(xmlDoc);
    var parsedString = parser.parse();
    print(parsedString);

    // The normalizer will normalize the parsed string according to SPDX guidlines
    // var normalizer = Normalize(parsedString);
  }
  else {
    print(response.reasonPhrase);
  }
}
void main() {
  parseLisence();
}
