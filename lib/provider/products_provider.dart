import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
//    Product(
//      id: 'p1',
//      title: 'Red Shirt',
//      description: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:
//          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//    ),
//    Product(
//      id: 'p2',
//      title: 'Trousers',
//      description: 'A nice pair of trousers.',
//      price: 59.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//    ),
//    Product(
//      id: 'p3',
//      title: 'Yellow Scarf',
//      description: 'Warm and cozy - exactly what you need for the winter.',
//      price: 19.99,
//      imageUrl:
//          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//    ),
//    Product(
//      id: 'p4',
//      title: 'A Pan',
//      description: 'Prepare any meal you want.',
//      price: 49.99,
//      imageUrl:
//          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product getProductsById(String id) {
    return _items.firstWhere((prod) {
      return prod.id == id;
    });
  }

  List<Product> get getFavourite {
    return _items.where((prod) {
      return prod.isFavourite;
    }).toList();
  }

  Future<void> getandsetProduct() async {
    try {
      const url =
          'https://flutter-firebase-shop-app.firebaseio.com/products.json';
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String,
          dynamic>; //dynnamic defines that its a map so map inside a map.
      List<Product> loadedProduct = [];
      extractedData.forEach((prodId, prodData) {
        loadedProduct.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
          isFavourite: prodData['isFavourite'],
          price: prodData['price'],
        ));
      }); //prodId = key and prodData=value
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      const url =
          'https://flutter-firebase-shop-app.firebaseio.com/products.json';

      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavourite,
        }),
      );

      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product editProduct) async{
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://flutter-firebase-shop-app.firebaseio.com/products/$id.json';
      await http.patch(url,body: json.encode({
        'title': editProduct.title,
        'description': editProduct.description,
        'price': editProduct.price,
        'imageUrl': editProduct.imageUrl,
      }));
      _items[prodIndex] = editProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    final url = 'https://flutter-firebase-shop-app.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProductData = _items[existingProductIndex];



    //this http.delete is optimistic updating that is if any error then dont delete the item keep its ref and add to list and if no error occurs then delte the data
    http.delete(url).then((response){
    if(response.statusCode >=400)
      {

      }
    }).catchError((_){
      _items.insert(existingProductIndex, existingProductData);
      notifyListeners();

    });

    _items.removeAt(existingProductIndex);
    notifyListeners();
  }
}
