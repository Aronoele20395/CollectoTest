import 'package:collecto/controllers/products_controller.dart';
import 'package:collecto/widgets/products_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewProductsPage extends StatelessWidget {
  const NewProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController controller = Get.find<ProductsController>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Cerca",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            onChanged: (value) {
              controller.filterProductsByName(value);
            },
          ),
        ),
        
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Obx(() {
                              final products = controller.getFilteredProductsByCategory("electronics");
                              if (controller.searchQuery.isNotEmpty && products.isEmpty) {
                                return const SizedBox.shrink(); //Nascondi se nessun risultato
                              }
                              return ProductsRow(
                                title: "Electronics",
                                controller: controller,
                                products: products,
                                onLoadMore: () => controller.loadMoreByCategory("electronics"),
                                isLoadingMore: controller.isLoadingMoreElectronics,
                              );
                            }),
                            
                            Obx(() {
                              final products = controller.getFilteredProductsByCategory("jewelery");
                              if (controller.searchQuery.isNotEmpty && products.isEmpty) {
                                return const SizedBox.shrink(); //Nascondi se nessun risultato
                              }
                              return ProductsRow(
                                title: "Jewelery",
                                controller: controller,
                                products: products,
                                onLoadMore: () => controller.loadMoreByCategory("jewelery"),
                                isLoadingMore: controller.isLoadingMoreJewelery,
                              );
                            }),
                            
                            Obx(() {
                              final products = controller.getFilteredProductsByCategory("men's clothing");
                              if (controller.searchQuery.isNotEmpty && products.isEmpty) {
                                return const SizedBox.shrink(); //Nascondi se nessun risultato
                              }
                              return ProductsRow(
                                title: "Men's clothing",
                                controller: controller,
                                products: products,
                                onLoadMore: () => controller.loadMoreByCategory("men's clothing"),
                                isLoadingMore: controller.isLoadingMoreMen,
                              );
                            }),
                            
                            Obx(() {
                              final products = controller.getFilteredProductsByCategory("women's clothing");
                              if (controller.searchQuery.isNotEmpty && products.isEmpty) {
                                return const SizedBox.shrink(); //Nascondi se nessun risultato
                              }
                              return ProductsRow(
                                title: "Women's clothing",
                                controller: controller,
                                products: products,
                                onLoadMore: () => controller.loadMoreByCategory("women's clothing"),
                                isLoadingMore: controller.isLoadingMoreWomen,
                              );
                            }),
                            
                            Obx(() {
                              final products = controller.getFilteredAllProducts();
                              if (controller.searchQuery.isNotEmpty && products.isEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      "Nessun prodotto trovato",
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              }
                              return ProductsRow(
                                title: "Tutti i prodotti",
                                controller: controller,
                                products: products,
                                onLoadMore: () => controller.loadMoreByCategory(null),
                                isLoadingMore: controller.isLoadingMore,
                              );
                            }),
                            
                            Obx(() {
                              final bool noResults = controller.searchQuery.isNotEmpty && 
                                controller.getFilteredProductsByCategory("electronics").isEmpty &&
                                controller.getFilteredProductsByCategory("jewelery").isEmpty && 
                                controller.getFilteredProductsByCategory("men's clothing").isEmpty && 
                                controller.getFilteredProductsByCategory("women's clothing").isEmpty && 
                                controller.getFilteredAllProducts().isEmpty;
                                
                              if (noResults) {
                                return Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 16),
                                        Text(
                                          "Nessun prodotto trovato",
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}