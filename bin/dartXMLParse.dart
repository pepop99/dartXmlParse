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
    var xmlString = xml.XmlDocument.parse(responseString);

    //print attributes of the xml file
    var attributes = xmlString.descendants;
    for(var attribute in attributes){
      for(var att in attribute.attributes){
        print(att);
      }
    }
  }
  else {
    print(response.reasonPhrase);
  }
}
void main() {
  parseLisence();
}
