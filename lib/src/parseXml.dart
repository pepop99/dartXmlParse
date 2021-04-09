import 'package:xml/xml.dart';

class xmlParser {
  XmlNode baseNode;

  //constructor to initialze class variables
  xmlParser(XmlNode baseNode){
    this.baseNode = baseNode;
  }

  //function to begin parsing
  String parse(){
    var buffer = StringBuffer();
    checkSubNode(buffer, baseNode);
    var parsedString = buffer.toString();
    return parsedString;
  }

  //helper function which will be called on every subnode of a node
  void checkSubNode(StringBuffer buffer, XmlNode baseNode){
    if(baseNode.nodeType == XmlNodeType.TEXT){
      var nodeText = baseNode.text;
      var trimmedText = nodeText.replaceAll(RegExp('[\n][ ]{2,}'), '').trim();
      if(trimmedText.isNotEmpty){
        buffer.write('$trimmedText\n');
      }
    }
    for(var node in baseNode.nodes){
      checkSubNode(buffer, node);
    }
  }
}