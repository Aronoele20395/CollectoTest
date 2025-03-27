import 'package:collecto/controllers/products_controller.dart';
import 'package:collecto/data/products_repo.dart';
import 'package:collecto/pages/home_page.dart';
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
      title: 'Collecto',
      theme: ThemeData(
        primaryColor: Color(0xFF09EBB0),
        appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Color(0xFF1C2C38)),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70
        ),
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(ProductsRepo());
        Get.put(ProductsController(Get.find()));
      }),
      home: const HomePage(),
    );
  }
}