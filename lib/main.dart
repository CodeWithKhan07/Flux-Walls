import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluxwalls/resources/app_theme/app_theme.dart';
import 'package:fluxwalls/routes/app_routes.dart';
import 'package:fluxwalls/utils/services/internet_check_service.dart';
import 'package:fluxwalls/utils/services/permission_service.dart';
import 'package:fluxwalls/view_models/bindings/initial_bindings.dart';
import 'package:fluxwalls/views/widgets/no_internet_widget/no_internet_widget.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PermissionService.requestStoragePermission();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            Obx(() {
              final isOffline = !Get.find<NetworkService>().isConnected.value;
              return isOffline
                  ? const NoInternetDialog() // Show when disconnected
                  : const SizedBox.shrink(); // Hide when connected
            }),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      getPages: AppRoutes.routes,
      initialRoute: RouteNames.splash,
    );
  }
}
