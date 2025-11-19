import 'package:get/get.dart';
import 'package:pas_mobile_11pplg2_11/pages/bookmark_page.dart';
import 'package:pas_mobile_11pplg2_11/pages/profile_page.dart';
import 'package:pas_mobile_11pplg2_11/pages/tvshow_page.dart';
import 'package:pas_mobile_11pplg2_11/routes/routes.dart';
import '../pages/splash_screen.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/home_page.dart';
import '../bindings/auth_binding.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashPage(), binding: AuthBinding()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage(), binding: AuthBinding()),
    GetPage(name: AppRoutes.register, page: () => const RegisterPage(), binding: AuthBinding()),
    GetPage(name: AppRoutes.profile, page: () => const ProfilePage (), binding: AuthBinding()),
    GetPage(name: AppRoutes.home, page: () => const HomePage(), binding: AuthBinding()),
    GetPage(name: AppRoutes.tvshow, page: () => const TvshowPage(), binding: AuthBinding()),
    GetPage(name: AppRoutes.bookmark, page: () => const BookmarkPage(), binding: AuthBinding()),
  ];
}
