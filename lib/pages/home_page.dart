import 'package:collecto/pages/new_products_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
      title: Padding(
        padding: EdgeInsets.fromLTRB(8, 30, 8, 15),
        child: Image.asset('assets/collecto.png', height: 150, fit: BoxFit.contain)),
            bottom: TabBar(
              tabs: [
                Tab(text: "Nuovi Beni"),
                Tab(text: "Marketplace"),
                Tab(text: "Beni Venduti"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              NewProductsPage(),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
