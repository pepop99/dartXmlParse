import 'package:xml/xml.dart';

class xmlParser {
  String xmlString;

  //constructor to initialze class variables
  xmlParser(String xmlString){
    this.xmlString = xmlString;
  }

  //function to get info of a particular property
  String parse(String property){
    var matchRegex = RegExp('(?<=$property=")(.*?)(?=")');
    var match = matchRegex.stringMatch(xmlString);
    return match;
  }

  //function to extract text from the license which will later be normalized and used to match licenses
  String extractText() {
    var temp = xmlString;
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
        temp = m;
      }
    }
    return temp;
  }

}