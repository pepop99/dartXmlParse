import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

void parseLisence() async{
  var url = Uri.parse('https://raw.githubusercontent.com/spdx/license-list-XML/master/src/MIT-Modern-Variant.xml');
  var request = http.Request('GET', url);
  
  var response = await request.send();
  
  if (response.statusCode == 200) {
    //code to store the streamed response as a string
    var responseString = '';
    await for (var bytes in response.stream.transform(Utf8Decoder())){
      responseString += bytes;
    }

    //parse the response string as xml
    // print(responseString);
    var normalizedString = responseString.replaceAll(new RegExp("<[^>]+>"), '');
    normalizedString = normalizedString.replaceAll(new RegExp("/^[\s#*_]*end of terms and conditions[\s#*_]*/i"), '');
    print(normalizedString);
    var xmlString = xml.XmlDocument.parse(responseString);
    
    // print(xmlString);
  }
  else {
    print(response.reasonPhrase);
  }
}
void main() {
  parseLisence();
}
