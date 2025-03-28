import 'package:collecto/controllers/products_controller.dart';
import 'package:collecto/widgets/products_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewProductsPage extends StatelessWidget {
  const NewProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController controller = Get.find<ProductsController>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      ProductsRow(
                        title: "Electronics",
                        controller: controller,
                        products:
                            controller.getProductsByCategory("electronics"),
                        onLoadMore: () =>
                            controller.loadMoreByCategory("electronics"),
                        isLoadingMore: controller.isLoadingMoreElectronics,
                      ),
                      ProductsRow(
                        title: "Jewelery",
                        controller: controller,
                        products: controller.getProductsByCategory("jewelery"),
                        onLoadMore: () =>
                            controller.loadMoreByCategory("jewelery"),
                        isLoadingMore: controller.isLoadingMoreJewelery,
                      ),
                      ProductsRow(
                        title: "Men's clothing",
                        controller: controller,
                        products:
                            controller.getProductsByCategory("men's clothing"),
                        onLoadMore: () =>
                            controller.loadMoreByCategory("men's clothing"),
                        isLoadingMore: controller.isLoadingMoreMen,
                      ),
                      ProductsRow(
                        title: "Women's clothing",
                        controller: controller,
                        products: controller
                            .getProductsByCategory("women's clothing"),
                        onLoadMore: () =>
                            controller.loadMoreByCategory("women's clothing"),
                        isLoadingMore: controller.isLoadingMoreWomen,
                      ),
                      ProductsRow(
                          title: "Tutti i prodotti",
                          controller: controller,
                          products: controller.getAllProducts(),
                          onLoadMore: () => controller.loadMoreByCategory(null),
                          isLoadingMore: controller.isLoadingMore)
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
