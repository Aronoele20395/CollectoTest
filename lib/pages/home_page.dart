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
            centerTitle: true,
            backgroundColor: Color(0xFF1C2C38),
            bottom: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(text: "Nuovi Beni"),
                Tab(text: "Marketplace"),
                Tab(text: "Beni Venduti"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.green,
              ),
              /* 
              NewProductsPage(),
              MarketplacePage(),
              SoldProductsPage(), */
            ],
          ),
        ),
      ),
    );
  }
}
