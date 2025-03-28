import 'package:collecto/data/products_repo.dart';
import 'package:collecto/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final ProductsRepo _repo;

  //RxLists per le diverse categorie
  final RxList<Product> electronics = <Product>[].obs;
  final RxList<Product> jewelery = <Product>[].obs;
  final RxList<Product> men = <Product>[].obs;
  final RxList<Product> women = <Product>[].obs;
  final RxList<Product> all = <Product>[].obs;

  //Stato di caricamento
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMoreElectronics = false.obs;
  final RxBool isLoadingMoreJewelery = false.obs;
  final RxBool isLoadingMoreMen = false.obs;
  final RxBool isLoadingMoreWomen = false.obs;
  final RxBool isLoadingMore = false.obs;

  //Paginazione
  final int perPage = 10;
  int electronicsOffset = 0;
  int jeweleryOffset = 0;
  int menOffset = 0;
  int womenOffset = 0;
  int offset = 0;

  ProductsController(this._repo);

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    try {
      isLoading.value = true;

      await Future.wait([
        loadMoreByCategory("electronics"),
        loadMoreByCategory("jewelery"),
        loadMoreByCategory("men's clothing"),
        loadMoreByCategory("women's clothing"),
        loadMoreByCategory(null)
      ]);
    } catch (e) {
      debugPrint("Errore nel caricamento dati: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreByCategory(String? category) async {
    try {
      if (category != null) {
        switch (category) {
          case "electronics":
            if (isLoadingMoreElectronics.value) return;
            isLoadingMoreElectronics.value = true;
            final products = await _repo.getProductsByCategory(category,
                limit: perPage, offset: electronicsOffset);
            electronics.addAll(products);
            electronicsOffset += products.length;
            isLoadingMoreElectronics.value = false;
            break;

          case "jewelery":
            if (isLoadingMoreJewelery.value) return;
            isLoadingMoreJewelery.value = true;
            final products = await _repo.getProductsByCategory(category,
                limit: perPage, offset: jeweleryOffset);
            jewelery.addAll(products);
            jeweleryOffset += products.length;
            isLoadingMoreJewelery.value = false;
            break;

          case "men's clothing":
            if (isLoadingMoreMen.value) return;
            isLoadingMoreMen.value = true;
            final products = await _repo.getProductsByCategory(category,
                limit: perPage, offset: menOffset);
            men.addAll(products);
            menOffset += products.length;
            isLoadingMoreMen.value = false;
            break;

          case "women's clothing":
            if (isLoadingMoreWomen.value) return;
            isLoadingMoreWomen.value = true;
            final products = await _repo.getProductsByCategory(category,
                limit: perPage, offset: womenOffset);
            women.addAll(products);
            womenOffset += products.length;
            isLoadingMoreWomen.value = false;
            break;
        }
      } else {
        isLoadingMore.value = true;
        final products =
            await _repo.getAllProducts(limit: perPage, offset: offset);
        debugPrint("All products loaded: ${products.length}");
        all.addAll(products);
        offset += products.length;
        isLoadingMore.value = false;
      }
    } catch (e) {
      debugPrint("Errore nel caricamento di $category: $e");
      //Reset stato di caricamento in caso di errore
      if (category != null) {
        switch (category) {
          case "electronics":
            isLoadingMoreElectronics.value = false;
            break;
          case "jewelery":
            isLoadingMoreJewelery.value = false;
            break;
          case "men's clothing":
            isLoadingMoreMen.value = false;
            break;
          case "women's clothing":
            isLoadingMoreWomen.value = false;
            break;
        }
      } else {
        isLoadingMore.value = false;
      }
    }
  }

  List<Product> getProductsByCategory(String category) {
    switch (category) {
      case "electronics":
        return electronics;
      case "jewelery":
        return jewelery;
      case "men's clothing":
        return men;
      case "women's clothing":
        return women;
      default:
        return [];
    }
  }

  List<Product> getAllProducts() {
    return all;
  }
}
