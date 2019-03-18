import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_course/models/product.dart';
import 'connected_products.dart';

mixin ProductsModel on ConnectedProducts {
  bool _showFavourites = false;

  List<Product> get allProducts {
    return List.from(products);
  }

  bool get displayFavouritesOnly {
    return _showFavourites;
  }

  List<Product> get displayedProducts {
    if (_showFavourites) {
      return List.from(
          products.where((Product product) => product.isFavourite).toList());
    }

    return List.from(products);
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return products[selectedProductIndex];
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

  void toggleProductFavourite() {
    final bool isCurrentlyFavourite =
        products[selectedProductIndex].isFavourite;
    final bool newFavouriteStatus = !isCurrentlyFavourite;
    final Product product = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavourite: newFavouriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);

    products[selectedProductIndex] = product;

    notifyListeners();
    selProductIndex = null;
  }

  void updateProduct(
      String title, String description, String image, double price) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    products[selectedProductIndex] = updatedProduct;
    selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selectedProductIndex);
    selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    selProductIndex = index;
  }

  void toggleDisplayMode() {
    _showFavourites = !_showFavourites;
    notifyListeners();
  }
}
