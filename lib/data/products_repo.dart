import 'dart:io';
import 'package:collecto/models/product.dart';
import 'package:dio/dio.dart';

class ProductsRepo {
  static const String _baseUrl = "https://fakestoreapi.com/";
  final Dio _dio;

  ProductsRepo({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  Future<List<Product>> getAllProducts() async {
    return _safeCall(() => _dio.get("products"), (productsData) => List<Product>.from(productsData));
  }

  Future<Product> getSingleProduct(int id) async {
    return _safeCall(() => _dio.get("products/$id"),
        (singleProduct) => Product.fromJson(singleProduct));
  }

  Future<List<String>> getCategories() async {
    return _safeCall(() => _dio.get("products/categories"), 
        (categoriesData) => (categoriesData as List)
            .map((category) => category.toString())
            .toList());
  }

  Future<List<Product>> getProductsByCategory(String category, {int limit = 10, int offset = 0}) async {
    return _safeCall(() => _dio.get("products/category/$category"), (productsData) {
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
  }

  Future<T> _safeCall<T>(Future<Response> Function() apiCall,
      T Function(dynamic data) onSuccess) async {
    try {
      final response = await apiCall();

      if (response.statusCode == 200) {
        final data = response.data;
        if (data["status"] == "success") {
          return onSuccess(data["message"]);
        } else {
          throw DioException(
            requestOptions: response.requestOptions,
            error: "Invalid response: ${data["message"]}",
          );
        }
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
