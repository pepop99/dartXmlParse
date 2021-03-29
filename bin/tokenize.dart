import 'dart:core';

class token {
  var text;
  var offset;
  token(){
    text = '';
    offset = -1;
  }
}


void tokenize(String s){
  var toks = [];
  var tok = token();
  var c = 0;
  for(var i=0;i<s.length;i++){
    var punctuationRegex = RegExp(r'[.,\/#!$%\^&\*;:{}=\-_`~()]');
    var spaceRegex = RegExp(r'\s');
    if(spaceRegex.hasMatch(s[i])){
      if(tok.offset >= 0){
        toks.add(tok);
        tok = token();
      }
    }
    else if(punctuationRegex.hasMatch(s[i])){
      if(tok.offset >= 0){
        toks.add(tok);
        tok = token();
      }
      var puncTok = token();
      puncTok.text = s[i];
      puncTok.offset = i;
      toks.add(puncTok);
    }
    else{
      if(tok.offset == -1){
        tok.offset = i;
      }
      tok.text += s[i];
    }
    if(tok.offset != -1){
      toks.add(tok);
    }
  }
  print(toks[1].text);
}

void main(){
  tokenize('redistribution and use in source and binary forms with or without modification are permitted provided that the following conditions are met 1 redistributions of source code must retain the above copyright notice this list of conditions and the following disclaimer 2 redistributions in binary form must reproduce the above copyright notice this list of conditions and the following disclaimer in the documentation and or other materials provided with the distribution this software is provided by the freebsd project as is and any express or implied warranties including but not limited to the implied warranties of merchantability and fitness for a particular purpose are disclaimed in no event shall the freebsd project or contributors be liable for any direct indirect incidental special exemplary or consequential damages including but not limited to procurement of substitute goods or services loss of use data or profits or business interruption however caused and on any theory of liability whether in contract strict liability or tort including negligence or otherwise arising in any way out of the use of this software even if advised of the possibility of such damage the views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies either expressed or implied of the freebsd project');
}