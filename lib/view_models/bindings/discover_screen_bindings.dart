import 'package:fluxwalls/view_models/controllers/discover_screen_controller.dart';
import 'package:get/get.dart';

class DiscoverScreenBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DiscoverScreenController>(() => DiscoverScreenController());
  }
}
