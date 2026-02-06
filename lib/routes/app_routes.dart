import 'package:fluxwalls/view_models/bindings/discover_screen_bindings.dart';
import 'package:fluxwalls/view_models/bindings/image_detail_bindings.dart';
import 'package:fluxwalls/views/categories/categories_screen.dart';
import 'package:fluxwalls/views/dashboard/dashboard_screen.dart';
import 'package:fluxwalls/views/discover/discover_screen.dart';
import 'package:fluxwalls/views/downloads/downloads_screen.dart';
import 'package:fluxwalls/views/imagedetail/image_detail_page.dart';
import 'package:fluxwalls/views/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteNames {
  static const String splash = "/splash";
  static const String dashboard = "/dashboard";
  static const String discover = "/discover";
  static const String categories = "/categories";
  static const String downloads = "/downloads";
  static const String imageDetailpage = "/imageDetailPage";
}

class AppRoutes {
  static Transition transition = Transition.leftToRight;
  static final routes = [
    GetPage(
      name: RouteNames.splash,
      page: () => SplashScreen(),
      transition: transition,
    ),
    GetPage(
      name: RouteNames.dashboard,
      page: () => DashboardScreen(),
      transition: transition,
    ),
    GetPage(
      name: RouteNames.discover,
      page: () => DiscoverScreen(),
      transition: transition,
      binding: DiscoverScreenBindings(),
    ),
    GetPage(
      name: RouteNames.categories,
      page: () => CategoriesScreen(),
      transition: transition,
    ),
    GetPage(
      name: RouteNames.downloads,
      page: () => DownloadsScreen(),
      transition: transition,
    ),
    GetPage(
      name: RouteNames.imageDetailpage,
      page: () => ImageDetailPage(),
      binding: ImageDetailBindings(),
      transitionDuration: Duration(milliseconds: 600),
      transition: Transition.upToDown,
    ),
  ];
}
