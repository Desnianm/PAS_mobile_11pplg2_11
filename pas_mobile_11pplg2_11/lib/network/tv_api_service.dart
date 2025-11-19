
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tv_model.dart';

class TvApiService {
  static final http.Client _client = http.Client();
  static const String _base = 'https://api.tvmaze.com';


  static Future<List<Tvmodel>> fetchShows() async {
    final uri = Uri.parse('$_base/shows');
    final res = await _client.get(uri);

    if (res.statusCode == 200) {

      return tvmodelFromJson(res.body);
    } else {
      throw Exception('Failed to fetch shows: ${res.statusCode}');
    }
  }


  static Future<List<Tvmodel>> fetchShowsByPage(int page) async {
    final uri = Uri.parse('$_base/shows?page=$page');
    final res = await _client.get(uri);

    if (res.statusCode == 200) {
      return tvmodelFromJson(res.body);
    } else {
      throw Exception('Failed to fetch shows page $page: ${res.statusCode}');
    }
  }


  static Future<Tvmodel> fetchShowById(int id) async {
    final uri = Uri.parse('$_base/shows/$id');
    final res = await _client.get(uri);
    if (res.statusCode == 200) {
      return Tvmodel.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to fetch show $id: ${res.statusCode}');
    }
  }
}
