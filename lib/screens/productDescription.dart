import 'package:animall_vendor/models/productFetch.dart';
import 'package:animall_vendor/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Description extends StatelessWidget {
  final routeName = '/desc';
  ProductModel data;
  @override
  Widget build(BuildContext context) {
    data = Provider.of<DatabaseFetch>(context, listen: true).giveSingleProduct;
    return Scaffold(
      appBar: AppBar(
        title: Text('Animall Vendor'),
      ),
      body:  data == null ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator())) :  Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           data.imageUrls.length <=1 ? Container(
             height: 250,
             width: MediaQuery.of(context).size.width,
             child: Image.network(data.imageUrls[0], fit: BoxFit.cover),
           ) : CarouselSlider(items: data.imageUrls.map((i) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.amber
          ),
          child: Image.network(i, fit: BoxFit.cover,),
        );
      },
    );
  }).toList(), 
  options: CarouselOptions(height: 250, autoPlayInterval: const Duration(seconds: 3),autoPlay: true, aspectRatio: 16/9, enlargeCenterPage: true, viewportFraction: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data.productName, style: TextStyle(fontSize: 22),),
                    Text('Rs. ${data.price.toInt().toString()}', style: TextStyle(fontSize: 24),),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                 SizedBox(height: 10),
                Text(data.productDescription, style: TextStyle(fontSize: 18),),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}