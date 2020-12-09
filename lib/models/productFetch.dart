import 'package:animall_vendor/models/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseFetch with ChangeNotifier{
List<ProductModel> finalproductList = List();
ProductModel tempProduct;
ProductModel singleProduct;
var docId;
var useriD = FirebaseAuth.instance.currentUser.uid;
ProductModel foundItem;
  Future<void> productFetch() async{
    print(useriD);
        List<ProductModel> productList = List();
        var userProducts = await FirebaseFirestore.instance.collection('Categories/').doc(useriD).collection('products/').get();
        // .orderBy('date', descending: true).get();
        userProducts.docs.forEach((element) { 
          print(element.data()['productName']);
          ProductModel data = ProductModel(
            productName: element.data()['productName'],
            productDescription: element.data()['productDesc'],
            price: element.data()['price'],
            imageUrls: element.data()['imagesUrl'],
            timestamp: element.data()['date'],
          );
          productList.add(data);
        });
        finalproductList = productList;
        notifyListeners();
  }  

  List<dynamic> get fetchedData{
    return [...finalproductList];
  }

  void findProduct(var timestamp){
    foundItem = finalproductList.firstWhere((element) => element.timestamp == timestamp);
  }

  void getId(ProductModel data, var docI){
    tempProduct = ProductModel(
      productName: data.productName,
      productDescription: data.productDescription,
      price: data.price,
      imageUrls: data.imageUrls,
    );
    docId = docI;
  }

  Future<void> singleProductFetch(docId) async{
    singleProduct = null;
    var product = await FirebaseFirestore.instance.collection('Categories/').doc(useriD).collection('products/').doc(docId).get();
    singleProduct = ProductModel(
      productName: product.data()['productName'],
      productDescription: product.data()['productDesc'],
      price: product.data()['price'],
      imageUrls: product.data()['imagesUrl'],
      timestamp: product.data()['date'],
    );
    notifyListeners();
    print (singleProduct.imageUrls);
  }

  ProductModel get giveSingleProduct{
    return singleProduct;
  }
}