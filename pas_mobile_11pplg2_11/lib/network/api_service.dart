import 'package:http/http.dart' as http;

class ApiService {

  static final http.Client client = http.Client();

  static const String registerUrl = "https://mediadwi.com/api/latihan/register-user";
  static const String loginUrl = "https://mediadwi.com/api/latihan/login";

  static Future<http.Response> registerUser(Map<String, String> data) async {
    return await client.post(Uri.parse(registerUrl), body: data);
  }

  static Future<http.Response> loginUser(Map<String, String> data) async {
    return await client.post(Uri.parse(loginUrl), body: data);
  }


}
