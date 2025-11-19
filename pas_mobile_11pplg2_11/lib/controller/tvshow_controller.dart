// lib/controllers/tvshow_controller.dart
import 'package:get/get.dart';
import '../models/tv_model.dart';
import '../network/tv_api_service.dart';

class TvShowController extends GetxController {
  var shows = <Tvmodel>[].obs;
  var loading = false.obs;
  var error = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchShows();
  }

  Future<void> fetchShows() async {
    try {
      loading.value = true;
      error.value = null;
      final list = await TvApiService.fetchShows();
      shows.assignAll(list);
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
