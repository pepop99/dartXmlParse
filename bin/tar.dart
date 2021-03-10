import 'package:http/http.dart' as http;

void getTarBallLink() async{
  var headers = {
    'Accept': 'application/vnd.pub.v2+json'
  };
  var request = http.Request('GET', Uri.parse('https://pub.dartlang.org/api/packages/location'));
  
  request.headers.addAll(headers);
  
  var response = await request.send();
  
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }
}
void main() {
  getTarBallLink();
}