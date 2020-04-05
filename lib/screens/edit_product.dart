import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttershopapp/provider/product.dart';
import '../provider/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeArgs = '/edit-product-screen';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocuesNode = FocusNode();
  final _descriptionFocuesNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  var _addedProduct = Product(
    title: '',
    price: 0,
    description: '',
    id: null,
    imageUrl: '',
  );
  var _editValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  var _isInit = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _addedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .getProductsById(productId);
        _editValues = {
          'title': _addedProduct.title,
          'price': _addedProduct.price.toString(),
          'description': _addedProduct.description,
          'imageUrl': '',
        };
        _imageUrlController.text = _addedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    var isvalid = _formKey.currentState.validate();
    if (!isvalid) {
      return;
    }
    _formKey.currentState.save();
    if (_addedProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_addedProduct.id, _addedProduct);
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addItems(_addedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocuesNode.dispose();
    _descriptionFocuesNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  initialValue: _editValues['title'],
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocuesNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Provide a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _addedProduct = Product(
                      id: _addedProduct.id,
                      isFavourite: _addedProduct.isFavourite,
                      title: value,
                      description: _addedProduct.description,
                      imageUrl: _addedProduct.imageUrl,
                      price: _addedProduct.price,
                    );
                  },
                ),
                TextFormField(
                  initialValue: _editValues['price'],
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Provide a value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please provide a valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please enter number greater than zero';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocuesNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocuesNode);
                  },
                  onSaved: (value) {
                    _addedProduct = Product(
                      id: _addedProduct.id,
                      isFavourite: _addedProduct.isFavourite,
                      title: _addedProduct.title,
                      description: _addedProduct.description,
                      imageUrl: _addedProduct.imageUrl,
                      price: double.parse(value),
                    );
                  },
                ),
                TextFormField(
                  initialValue: _editValues['description'],
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Provide a value';
                    }
                    if (value.length < 10) {
                      return 'Please enter 10 characters long';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocuesNode,
                  onSaved: (value) {
                    _addedProduct = Product(
                      id: _addedProduct.id,
                      isFavourite: _addedProduct.isFavourite,
                      title: _addedProduct.title,
                      description: value,
                      imageUrl: _addedProduct.imageUrl,
                      price: _addedProduct.price,
                    );
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? Text('Enter Image Url')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _imageUrlController,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        focusNode: _imageUrlFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Provide a value';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please enter a valid url';
                          }
//                          if (!value.endsWith('.png') &&
//                              !value.endsWith('.jpg') &&
//                              !value.endsWith('.jpeg')) {
//                            return 'Please enter a valid image url';
//                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'ImageUrl'),
                        onSaved: (value) {
                          _addedProduct = Product(
                            id: _addedProduct.id,
                            isFavourite: _addedProduct.isFavourite,
                            title: _addedProduct.title,
                            description: _addedProduct.description,
                            imageUrl: value,
                            price: _addedProduct.price,
                          );
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
