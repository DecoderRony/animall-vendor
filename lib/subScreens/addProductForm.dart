import 'package:animall_vendor/models/dbUploads.dart';
import 'package:animall_vendor/models/gradientButton.dart';
import 'package:animall_vendor/models/productFetch.dart';
import 'package:animall_vendor/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class ProductForm extends StatefulWidget {
  var _isEditable;
  ProductForm(
    this._isEditable,
  );
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  var _isUploading = false;

  List<Asset> selectedImages = List<Asset>();
  final _productFormKey = GlobalKey<FormState>();
  Future<void> pickImages() async {
    List<Asset> currentSelection = List<Asset>();
    currentSelection = await MultiImagePicker.pickImages(
      maxImages: 5,
      enableCamera: true,
      selectedAssets: selectedImages,
      materialOptions: MaterialOptions(
        actionBarTitle: "Gallery",
        allViewTitle: "All Photos",
      ),
    );

    if (!mounted) return;

    setState(() {
      selectedImages = currentSelection;
    });
  }

  ProductModel addingProduct = ProductModel(
    productName: null,
    productDescription: null,
    price: null,
    productImages: null,
  );

  @override
  void initState() {
    _isUploading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductModel _dataFound =
        Provider.of<DatabaseFetch>(context, listen: false).tempProduct;
    var docId = Provider.of<DatabaseFetch>(context, listen: false).docId;
    return SingleChildScrollView(
      child: Form(
        key: _productFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: _dataFound != null ? _dataFound.productName : null,
              decoration: InputDecoration(
                  labelText: 'Product Name',
                  enabledBorder: UnderlineInputBorder()),
              onSaved: (name) {
                addingProduct = ProductModel(
                  productName: name,
                  productDescription: addingProduct.productDescription,
                  price: addingProduct.price,
                  productImages: addingProduct.productImages,
                );
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue:
                  _dataFound != null ? _dataFound.productDescription : null,
              decoration: InputDecoration(
                labelText: 'Description',
                enabledBorder: UnderlineInputBorder(),
              ),
              maxLines: 2,
              onSaved: (description) {
                addingProduct = ProductModel(
                  productName: addingProduct.productName,
                  productDescription: description,
                  price: addingProduct.price,
                  productImages: addingProduct.productImages,
                );
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              initialValue:
                  _dataFound != null ? _dataFound.price.toString() : null,
              decoration: InputDecoration(
                  labelText: 'Price',
                  prefix: Text('₨ '),
                  enabledBorder: UnderlineInputBorder()),
              keyboardType: TextInputType.number,
              onSaved: (price) {
                addingProduct = ProductModel(
                  productName: addingProduct.productName,
                  productDescription: addingProduct.productDescription,
                  price: double.parse(price),
                  productImages: addingProduct.productImages,
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add Product Images (Max: 5)'),
                IconButton(icon: Icon(Icons.add_a_photo), onPressed: pickImages)
              ],
            ),
            selectedImages.length <= 0
                ? Container()
                : Container(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(selectedImages.length, (index) {
                        Asset asset = selectedImages[index];
                        return Row(
                          children: [
                            AssetThumb(asset: asset, width: 100, height: 100),
                            SizedBox(width: 5),
                          ],
                        );
                      }),
                    ),
                  ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: 
                    GradientButton(child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: widget._isEditable
                        ? _isUploading
                            ? Container(
                                height: 15,
                                width: 35,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  color: Colors.white,
                                ))
                            : Text(
                                'Update Product',
                                style: TextStyle(color: Colors.white),
                              )
                        : _isUploading
                            ? Container(
                                height: 15,
                                width: 35,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  color: Colors.white,
                                ))
                            : Text(
                                'Add Product',
                                style: TextStyle(color: Colors.white),
                              ),
                  ),
                  onPressed: _isUploading
                      ? () {}
                      : () async {
                          addingProduct = ProductModel(
                            productName: addingProduct.productName,
                            productDescription:
                                addingProduct.productDescription,
                            price: addingProduct.price,
                            productImages: selectedImages,
                          );
                          _productFormKey.currentState.save();
                          setState(() {
                            _isUploading = true;
                          });
                          widget._isEditable
                              ? FirebaseUploads()
                                  .updateProduct(addingProduct, context, docId)
                              : 
                                 
                                  FirebaseUploads()
                                      .addProduct(addingProduct, context);
                              
                          _dataFound = null;
                        },
                        gradient: LinearGradient(colors: [HexColor('#380036'), HexColor('#0CBABA')], begin: Alignment.topLeft, end: Alignment.bottomRight),
                         
                  )
                //     RaisedButton(
                    
                //   onPressed: _isUploading
                //       ? () {}
                //       : () async {
                //           addingProduct = ProductModel(
                //             productName: addingProduct.productName,
                //             productDescription:
                //                 addingProduct.productDescription,
                //             price: addingProduct.price,
                //             productImages: selectedImages,
                //           );
                //           _productFormKey.currentState.save();
                //           setState(() {
                //             _isUploading = true;
                //           });
                //           widget._isEditable
                //               ? FirebaseUploads()
                //                   .updateProduct(addingProduct, context, docId)
                //               : 
                                 
                //                   FirebaseUploads()
                //                       .addProduct(addingProduct, context);
                              
                //           _dataFound = null;
                //         },
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 15),
                //     child: widget._isEditable
                //         ? _isUploading
                //             ? Container(
                //                 height: 15,
                //                 width: 35,
                //                 child: LoadingIndicator(
                //                   indicatorType: Indicator.ballPulse,
                //                   color: Colors.white,
                //                 ))
                //             : Text(
                //                 'Update Product',
                //                 style: TextStyle(color: Colors.white),
                //               )
                //         : _isUploading
                //             ? Container(
                //                 height: 15,
                //                 width: 35,
                //                 child: LoadingIndicator(
                //                   indicatorType: Indicator.ballPulse,
                //                   color: Colors.white,
                //                 ))
                //             : Text(
                //                 'Add Product',
                //                 style: TextStyle(color: Colors.white),
                //               ),
                //   ),
                //   color: Colors.blue,
                // )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
