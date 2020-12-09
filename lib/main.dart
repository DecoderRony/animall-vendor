import 'package:animall_vendor/models/productFetch.dart';
import 'package:animall_vendor/screens/addProductScreen.dart';
import 'package:animall_vendor/screens/landingscreen.dart';
import 'package:animall_vendor/screens/loginScreen.dart';
import 'package:animall_vendor/screens/otpScreen.dart';
import 'package:animall_vendor/screens/productDescription.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => DatabaseFetch(),),
      ],
          child: MaterialApp(
        routes: {
          '/' : (context) => LoginScreen(),
          '/landingScreen' : (context) => LandingScreen(),
          '/otpScreen' : (context) => OtpScreen(),
          LandingScreen().routeName : (context) => AddProduct(),
          Description().routeName : (context) => Description(),
        },
      ),
    );
  }
}