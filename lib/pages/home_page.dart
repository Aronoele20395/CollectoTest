import 'package:collecto/pages/new_products_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                child: Image.asset('assets/collecto.png',
                    height: 150, fit: BoxFit.contain)),
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
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            onTap: (index) {
              switch (index) {
                case 0:
                  Get.offAllNamed('/');
                  break;
                case 1:
                  Get.offAllNamed('/collection');
                  break;
                case 2:
                  Get.offAllNamed('/notification');
                  break;
                case 3:
                  Get.offAllNamed('/profile');
                  break;
              }
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).highlightColor,
            unselectedItemColor:
                Theme.of(context).highlightColor.withAlpha(150),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Marketplace',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: 'Collezione',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none),
                label: 'Notifiche',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profilo',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
