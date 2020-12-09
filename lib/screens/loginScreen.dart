import 'package:animall_vendor/models/phoneAuth.dart';
import "package:flutter/material.dart";
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  
  final fkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
      var phoneNo;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor('#380036'), HexColor('#0CBABA')],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 115),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Animall',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Login/Signup',
                style: TextStyle(
                    fontSize: 20, letterSpacing: 1, color: Colors.white),
              ),
              SizedBox(height: 10),
              Form(
                  key: fkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Theme(
                        data: ThemeData(
                          primaryColor: Colors.white,
                          hintColor: Colors.white,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Mobile No.',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixText: '+91 ',
                              prefixStyle: TextStyle(color: Colors.white70),
                              hintStyle: TextStyle(color: Colors.white),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          onSaved: (newValue) => phoneNo = newValue,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: RaisedButton(
                                  onPressed: () {
                                    if (fkey.currentState.validate()) {
                                      fkey.currentState.save();
                                      Authorize().auth(phoneNo, context);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          letterSpacing: 1, fontSize: 16),
                                    ),
                                  ))),
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
