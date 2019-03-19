import 'package:scoped_model/scoped_model.dart';

import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/models/user.dart';

mixin ConnectedProductsModel on Model {
  final List<Product> _products = [];
  User _authenticatedUser;
  int _selProductIndex;

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id);
    _products.add(newProduct);
    _selProductIndex = null;
    notifyListeners();
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavourites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  bool get displayFavouritesOnly {
    return _showFavourites;
  }

  List<Product> get displayedProducts {
    if (_showFavourites) {
      return List.from(
          _products.where((Product product) => product.isFavourite).toList());
    }

    return List.from(_products);
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  void toggleProductFavourite() {
    final bool isCurrentlyFavourite =
        _products[selectedProductIndex].isFavourite;
    final bool newFavouriteStatus = !isCurrentlyFavourite;
    final Product product = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavourite: newFavouriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);

    _products[selectedProductIndex] = product;

    notifyListeners();
    _selProductIndex = null;
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
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
    _selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }

  void toggleDisplayMode() {
    _showFavourites = !_showFavourites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: '1', email: email, password: password);
  }
}
