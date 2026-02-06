import 'package:get/get.dart';

import '../../utils/services/internet_check_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkService(), permanent: true);
  }
}
