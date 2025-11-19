import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_11/controller/bookmark_controller.dart';
import 'package:pas_mobile_11pplg2_11/controller/tvshow_controller.dart';
import '../controller/auth_controller.dart';

import '../controller/profile_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<BookmarkController>(() => BookmarkController());
    Get.lazyPut<TvShowController>(() => TvShowController());
  }
}