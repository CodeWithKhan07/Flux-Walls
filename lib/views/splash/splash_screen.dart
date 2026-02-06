import 'package:flutter/material.dart';
import 'package:fluxwalls/routes/app_routes.dart';
import 'package:fluxwalls/views/widgets/animinated_text.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Get.offAllNamed(RouteNames.dashboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Animation
          SizedBox.expand(
            child: Lottie.asset('assets/wallanim.json', fit: BoxFit.cover),
          ),
          // Text Overlay
          Align(
            alignment: Alignment.center,
            child: TextAnimationWidget(
              label: "Flux Walls",
              onfinished: () {},
              labelstyle: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontSize: 35, letterSpacing: 2),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: Get.height * .48,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(100),
              child: Lottie.asset("assets/Loading.json", repeat: false),
            ),
          ),
        ],
      ),
    );
  }
}
