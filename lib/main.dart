import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:timezone/data/latest.dart' as timezone;
import 'app/utils/services/internet_connectivity_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  timezone.initializeTimeZones();
  final connectionStatus = ConnectionStatusSingleton.instance;
  connectionStatus.initialize();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
