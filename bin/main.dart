import 'dart:convert';
import 'package:http/http.dart' as http;
import 'normalize.dart';
import 'package:xml/xml.dart';

import 'parseXml.dart';

void parseLisence() async{
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

    //trial code to strip xml and extract text
    var temp = responseString;
    temp = temp.replaceAll(RegExp(r'\n'), '');
    temp = temp.replaceAll(RegExp(r'\r'), '');
    // temp = temp.replaceAll(RegExp(r'\s{2,}'), ' ');
    var exp = RegExp(r'<text>(.*)<\/text>');
    var matches = exp.allMatches(temp);
    if(matches.isNotEmpty) {
      var match = matches.elementAt(0);
      if(match != null) {
        var m = match.group(0);
        m = m.replaceAll(RegExp(r'<copyrightText>.*?<\/copyrightText>'), '');
        m = m.replaceAll(RegExp(r'<titleText>.*?<\/titleText>'), '');
        m = m.replaceAll(RegExp(r'<optionalText>.*?<\/optionalText>'), '');
        m = m.replaceAll(RegExp(r'<.*?>'), '');
        m = m.replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), ' ');
        m = m.replaceAll(RegExp(r'\s{2,}'), ' ');
        m = m.trim();
        m = m.toLowerCase();
        print(m);
      }
    }
    //trial code ends
    
    var xmlDoc = XmlDocument.parse(responseString);

    // parse the response string
    var parser = xmlParser(xmlDoc);
    var parsedString = parser.parse();
    // print(parsedString);

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
