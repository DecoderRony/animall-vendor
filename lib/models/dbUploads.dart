import 'package:animall_vendor/models/productModel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class FirebaseUploads{
  List _imageUrl = List<String>();
  Future<List<String>> uploadImages(var product, formContext)async{
     for(final image in product.productImages){
        StorageReference reference = FirebaseStorage.instance.ref().child('categories/${image.name}');
      ByteData byteData = await image.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
       StorageUploadTask uploadTask = reference.putData(imageData);
      await uploadTask.onComplete;
      var url = await reference.getDownloadURL();
      _imageUrl.add(url);
      print(_imageUrl[0]);
     }
  //  await product.productImages.forEach((image) async{
  //     StorageReference reference = FirebaseStorage.instance.ref().child('categories/${image.name}');
  //     ByteData byteData = await image.getByteData();
  //     List<int> imageData = byteData.buffer.asUint8List();
  //      StorageUploadTask uploadTask = reference.putData(imageData);
  //     await uploadTask.onComplete;
  //     var url = await reference.getDownloadURL();
  //     _imageUrl.add(url);
  //     print(_imageUrl[0]);
  //   });

    return _imageUrl;
  }

  Future<void> addProduct(var product, formContext) async{
    _imageUrl = await uploadImages(product, formContext);
      var userId = FirebaseAuth.instance.currentUser.uid;

    print("HeHEHEHEHE");
    print(userId);
    //   _imageUrl = List<String>();
    //  await product.productImages.forEach((image){
    //   StorageReference reference = FirebaseStorage.instance.ref().child('categories/${image.name}');
    //   ByteData byteData = image.getByteData();
    //   List<int> imageData = byteData.buffer.asUint8List();
    //    StorageUploadTask uploadTask = reference.putData(imageData);
    //   uploadTask.onComplete;
    //   var url = reference.getDownloadURL();
    //   _imageUrl.add(url);
    // }
    // );
      final ref = FirebaseFirestore.instance.collection('Categories/').doc(userId).collection('products/');
      await ref.add({
        'productName' : product.productName,
        'productDesc' : product.productDescription,
        'price' : product.price,
        'imagesUrl' : _imageUrl,
        'date' : DateTime.now().toIso8601String(),
      });
      // await ref.add({
      //   'productName' : product.productName,
      //   'productDesc' : product.productDescription,
      //   'price' : product.price,
      //   'imagesUrl' : _imageUrl,
      //   'date' : DateTime.now().toIso8601String(),
      // } 
      // );
            print('check 1');

      print(product.price);
      // Provider.of<DatabaseFetch>(formContext).productFetch();
       Navigator.of(formContext).pop();

    return;
  }

  Future<void> updateProduct(var product, formContext, var docId) async{
     List _imageUrl = List<String>();
    product.productImages.forEach((image) async{
      StorageReference reference = FirebaseStorage.instance.ref().child('categories/${image.name}');
      ByteData byteData = await image.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
       StorageUploadTask uploadTask = reference.putData(imageData);
      await uploadTask.onComplete;
      var url = await reference.getDownloadURL();
      _imageUrl.add(url);
            print('This is the images url');
      print(_imageUrl[0]);
     
       product = ProductModel(
         productName: product.productName,
         productDescription: product.productDescription,
         price: product.price,
         imageUrls: _imageUrl,
          timestamp: DateTime.now().toIso8601String(),
       );
      final ref = FirebaseFirestore.instance.collection('Categories/');
      print(docId);
      await ref.doc(docId).update(
        {
          'productName' : product.productName,
          'productDesc' : product.productDescription,
          'price' : product.price,
          'imagesUrl' : product.imageUrls,
          'date' : DateTime.now(),
        }
      );
      print(product.price);
      Navigator.of(formContext).pop();
    }
    );
  }
//     );
//     return;
//   }

    Future<void> deleteProduct(var id) async{
       final ref = FirebaseFirestore.instance.collection('Categories/');
       ref.doc(id).delete();
    }
}