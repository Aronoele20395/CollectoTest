import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductRowController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final RxBool isDesktop = false.obs;
  final Function() onLoadMore;
  final RxBool isLoadingMore;
  
  ProductRowController({required this.onLoadMore, required this.isLoadingMore});
  
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    
    //Determina se siamo su desktop per impostare correttamente le funzioni di scroll
    isDesktop.value = defaultTargetPlatform == TargetPlatform.windows || 
                      defaultTargetPlatform == TargetPlatform.macOS || 
                      defaultTargetPlatform == TargetPlatform.linux;
  }
  
  void _scrollListener() {
    if (scrollController.hasClients && 
        !isLoadingMore.value && 
        scrollController.position.pixels > scrollController.position.maxScrollExtent - 200) {
      onLoadMore();
    }
  }
  
  void scrollBack() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        (scrollController.offset - 300).clamp(0, scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  
  void scrollForward() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        (scrollController.offset + 300).clamp(0, scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  
  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }
}