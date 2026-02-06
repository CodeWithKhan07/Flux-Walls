import 'package:fluxwalls/view_models/controllers/image_detail_screen_controller.dart';
import 'package:get/get.dart';

class ImageDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageDetailController());
  }
}
