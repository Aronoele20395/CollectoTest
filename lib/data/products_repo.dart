import 'dart:io';
import 'package:collecto/models/product.dart';
import 'package:dio/dio.dart';

class ProductsRepo {
  static const String _baseUrl = "https://fakestoreapi.com/";
  final Dio _dio;

  ProductsRepo({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

//FakeStoreAPI non supporta l'offset per cui ho dovuto utilizzare un'alternativa che prevede il salvataggio di tutti i prodotti in una variabile locale da cui poi prelevare man mano quelli desiderati.
//Non è una soluzione ottimale e non la utilizzerei in un contesto diverso da quello di un esercizio di test.
//Lascio commentata qui sotto la soluzione che avrei utilizzato con la possibilità di utilizzare un parametro di offset nella chiamata (altrettanto vale per i prodotti suddivisi per categoria).

  /* Future<List<Product>> getAllProducts({int limit = 10, int offset = 0}) async {
    return _safeCall(() => _dio.get("products"), (productsData) {
      final allProducts = (productsData as List)
          .map((item) => Product.fromJson(item))
          .toList();

      //Paginazione
      final end = offset + limit;
      if (allProducts.isEmpty || offset >= allProducts.length) {
        return <Product>[];
      }
      
      return end > allProducts.length 
          ? allProducts.sublist(offset) 
          : allProducts.sublist(offset, end);
    });
  } */

  List<Product> _allProductsCache = [];
  bool _isAllProductsCached = false;

  Future<List<Product>> getAllProducts({int limit = 10, int offset = 0}) async {
    if (!_isAllProductsCached) {
      //Carico tutti i prodotti una sola volta
      final fullList = await _safeCall(
          () => _dio.get("products"),
          (productsData) => (productsData as List)
              .map((item) => Product.fromJson(item))
              .toList());
      _allProductsCache = fullList;
      _isAllProductsCached = true;
      print("Cached all ${_allProductsCache.length} products");
    }

    //Paginazione dalla lista salvata in locale
    if (_allProductsCache.isEmpty || offset >= _allProductsCache.length) {
      return <Product>[];
    }

    final end = offset + limit;
    final paginatedResults = end > _allProductsCache.length
        ? _allProductsCache.sublist(offset)
        : _allProductsCache.sublist(offset, end);

    print(
        "Carico ${paginatedResults.length} prodotti (offset: $offset, limit: $limit)");
    return paginatedResults;
  }

  Future<Product> getSingleProduct(int id) async {
    return _safeCall(() => _dio.get("products/$id"),
        (singleProduct) => Product.fromJson(singleProduct));
  }

  Future<List<String>> getCategories() async {
    return _safeCall(
        () => _dio.get("products/categories"),
        (categoriesData) => (categoriesData as List)
            .map((category) => category.toString())
            .toList());
  }

  Map<String, List<Product>> _categoryProductsCache = {};
  
  Future<List<Product>> getProductsByCategory(String category,
      {int limit = 10, int offset = 0}) async {
    //controllo se i prodotti per questa categoria sono già in cache
    if (!_categoryProductsCache.containsKey(category)) {
      final fullList = await _safeCall(
          () => _dio.get("products/category/$category"),
          (productsData) => (productsData as List)
              .map((item) => Product.fromJson(item))
              .toList());
      _categoryProductsCache[category] = fullList;
    }

    final cachedProducts = _categoryProductsCache[category] ?? [];

    if (cachedProducts.isEmpty || offset >= cachedProducts.length) {
      return <Product>[];
    }

    final end = offset + limit;
    final paginatedResults = end > cachedProducts.length
        ? cachedProducts.sublist(offset)
        : cachedProducts.sublist(offset, end);

    print(
        "Carico ${paginatedResults.length} prodotti per la categoria $category (offset: $offset, limit: $limit)");
    return paginatedResults;
  }

  Future<T> _safeCall<T>(Future<Response> Function() apiCall,
      T Function(dynamic data) onSuccess) async {
    try {
      final response = await apiCall();

      if (response.statusCode == 200) {
        final data = response.data;
        return onSuccess(data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          error: "Errore HTTP: ${response.statusCode}",
        );
      }
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          throw Exception("Timeout connessione");
        } else if (e.type == DioExceptionType.unknown &&
            e.error is SocketException) {
          throw Exception("Nessuna connessione a Internet");
        }
        rethrow;
      }
      throw Exception("Errore generico: $e");
    }
  }
}
