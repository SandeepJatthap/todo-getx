import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/app/global_components/background.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.addDelay();
    return Background(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Lottie.asset('assets/splash_animation.json'),
      ),
    ));
  }
}
