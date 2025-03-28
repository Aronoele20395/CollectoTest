import 'package:collecto/controllers/products_controller.dart';
import 'package:collecto/controllers/products_row_controller.dart';
import 'package:collecto/models/product.dart';
import 'package:collecto/widgets/product_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsRow extends StatelessWidget {
  final String title;
  final ProductsController controller;
  final List<Product> products;
  final Function() onLoadMore;
  final RxBool isLoadingMore;
  
  ProductsRow({
    super.key, 
    required this.title, 
    required this.controller,
    required this.products,
    required this.onLoadMore,
    required this.isLoadingMore,
  }) {
    //Aggiunge un controller mper riga quando viene creato il widget
    Get.put(ProductRowController(
      onLoadMore: onLoadMore, 
      isLoadingMore: isLoadingMore
    ), tag: title);
  }
  
  ProductRowController get rowController => Get.find<ProductRowController>(tag: title);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              
              //Pulsanti di navigazione (solo su desktop)
              Obx(() => rowController.isDesktop.value
                ? Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: rowController.scrollBack,
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: rowController.scrollForward,
                      ),
                    ],
                  )
                : const SizedBox.shrink()
              ),
            ],
          ),
        ),
        
        SizedBox(
          height: 320,
          child: Obx(() => 
            products.isEmpty
              ? const Center(child: Text("Nessun prodotto disponibile"))
              : ScrollConfiguration(
                  //Configura lo scroll su desktop
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.trackpad
                    },
                  ),
                  child: ListView.builder(
                    controller: rowController.scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: products.length + 1,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: ProductCard(product: products[index]),
                        );
                      } else {
                        return isLoadingMore.value
                          ? const SizedBox(
                              width: 100,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox(width: 0);
                      }
                    },
                  ),
                ),
          ),
        ),
      ],
    );
  }
}