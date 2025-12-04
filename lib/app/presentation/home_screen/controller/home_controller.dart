import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentPage = 0.obs;

  // Dummy images untuk carousel, nanti bisa diganti dari API / assets
  final List<String> sliderImages = [
    'https://images.pexels.com/photos/460621/pexels-photo-460621.jpeg',
    'https://images.pexels.com/photos/1430677/pexels-photo-1430677.jpeg',
    'https://images.pexels.com/photos/1580285/pexels-photo-1580285.jpeg',
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }
}