
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> httpRequest(String body, String path) async {

  var url = Uri.http('192.168.0.110:8080', path);

  var response = await http.post(url, body: body);

  // print('Response status: ${response.statusCode}');
  //
  // print('Response body: ${response.body}');

  Map<String, dynamic> data = json.decode(response.body)['data'];

  // print('Response body: ${data["response"]}');

  return data;

  // print(data['number_phone']);
  // print(data['password']);

}