import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/tv_model.dart';
 
class TvShowController extends GetxController {
  var shows = <Tvmodel>[].obs;
  var loading = false.obs;
  var error = Rx<String?>(null);

  @override
  void onInit() {
    fetchShows(); 
    super.onInit();
   }

  Future<void> fetchShows() async {
    try {
      loading.value = true;
      error.value = null;

      final url = Uri.parse("https://api.tvmaze.com/shows");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        shows.value = tvmodelFromJson(response.body);
      } else {
        error.value = "Server Error";
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Future<void> refresh() async {
    await fetchShows();
  }
}
