import 'package:animall_vendor/subScreens/addProductForm.dart';

import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:hexcolor/hexcolor.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        var _isEditable = ModalRoute.of(context).settings.arguments;

    return Scaffold(
          appBar: GradientAppBar(
            title: Text('Add Product'),
                                    gradient: LinearGradient(colors: [HexColor('#380036'), HexColor('#0CBABA')], begin: Alignment.topLeft, end: Alignment.bottomRight),

          ),
          
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
        child: ProductForm(_isEditable)
      ),
          ),
    );
  }
}