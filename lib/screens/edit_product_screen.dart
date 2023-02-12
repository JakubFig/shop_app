import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.description);
    print(_editedProduct.imageUrl);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: '',
                          title: value!,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please provide a value';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Price'),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: '',
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value!),
                          imageUrl: _editedProduct.imageUrl);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a price.';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number.';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Please enter a number greater than zero';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: '',
                          title: _editedProduct.title,
                          description: value!,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description';
                      }
                      if (value.length < 10) {
                        return 'Description should be longer than 10 characters long';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(
                          top: 8,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter an URL')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          onEditingComplete: () {
                            setState(() {});
                          },
                          onFieldSubmitted: (_) {
                            _saveForm();
                          },
                          onSaved: (value) {
                            _editedProduct = Product(
                                id: '',
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: value!);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an image URL';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL';
                            }
                            if (!value.endsWith('.png') &&
                                !value.endsWith('.jpg') &&
                                !value.endsWith('jpeg')) {
                              return 'Please enter a valid URL';
                            } else {
                              return null;
                            }
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}



/*
Expanded(
  child: TextFormField(
    decoration: InputDecoration(labelText: 'Image URL'),
    keyboardType: TextInputType.url,
    textInputAction: TextInputAction.done,
    controller: _imageUrlController,
    onEditingComplete: () {
      setState(() {});
    },
  )
),
*/