import 'package:collecto/controllers/products_controller.dart';
import 'package:collecto/data/products_repo.dart';
import 'package:collecto/pages/home_page.dart';
import 'package:collecto/utils/routes.dart';
import 'package:collecto/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: navigationRoutes,
      title: 'Collecto',
      theme: collectoTheme,
      initialBinding: BindingsBuilder(() {
        Get.put(ProductsRepo());
        Get.put(ProductsController(Get.find()));
      }),
      home: const HomePage(),
    );
  }
}