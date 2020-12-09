import 'package:animall_vendor/screens/productList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:hexcolor/hexcolor.dart';

class LandingScreen extends StatefulWidget {
  final String routeName = '/AddProduct';
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  void _onTap(var index){
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _screens = [
    ProductList(),
    Text('Profile Screen')
  ];

  var _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
        Firebase.initializeApp();

    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Animall-Vendor'),
        gradient: LinearGradient(
                colors: [HexColor('#380036'), HexColor('#0CBABA')],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
      
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          activeIcon: ShaderMask(shaderCallback: (Rect bounds){
            return RadialGradient(colors: [HexColor('#380036'), HexColor('#0CBABA')], center: Alignment.topLeft, radius: 1, tileMode: TileMode.repeated).createShader(bounds);
            
          },
          child: Icon(Icons.line_style),
          )
          ,icon: Icon(Icons.line_style), title: _selectedIndex == 0 ? ShaderMask(shaderCallback: (Rect bounds){
            return RadialGradient(colors: [HexColor('#380036'), HexColor('#0CBABA')], center: Alignment.topLeft, radius: 1, tileMode: TileMode.repeated).createShader(bounds);
          }, child: Text('Products'),) : Text('Products')),
        BottomNavigationBarItem(activeIcon: ShaderMask(shaderCallback: (Rect bounds){
            return RadialGradient(colors: [HexColor('#380036'), HexColor('#0CBABA')], center: Alignment.topLeft, radius: 1, tileMode: TileMode.repeated).createShader(bounds);
            
          },
          child: Icon(Icons.account_circle),
          )
          ,
          icon: Icon(Icons.account_circle), title: _selectedIndex == 1 ? ShaderMask(shaderCallback: (Rect bounds){
            return RadialGradient(colors: [HexColor('#380036'), HexColor('#0CBABA')], center: Alignment.topLeft, radius: 1, tileMode: TileMode.repeated).createShader(bounds);
            
          },
          child: Text('Profile'),
          ) : Text('Profile')),
      ],
      currentIndex: _selectedIndex,
      onTap: _onTap,
      ),
      floatingActionButton: FloatingActionButton(child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [HexColor('#380036'), HexColor('#0CBABA')], begin: Alignment.topLeft, end: Alignment.bottomRight)
        ),
        child: Icon(Icons.add, color: Colors.white,)),onPressed: (){
        Navigator.of(context).pushNamed(widget.routeName, arguments: false);
      },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: _screens[_selectedIndex],
      ),),
    );
  }
}