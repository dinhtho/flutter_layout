import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkProvider {
  static var baseUrl = 'http://api.dev.basetax.co.uk/v4/';

  static Future<dynamic> post(String subDomain, var body) async {
    var url = baseUrl + subDomain;
    return await http.post(Uri.encodeFull(url),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json"
        }).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(response.toString());
        throw new Exception("Error while fetching data");
      }
      return new JsonDecoder().convert(response.body);
    });
  }
}
