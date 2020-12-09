import 'package:animall_vendor/models/phoneAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var otp;
    List data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor('#380036'), HexColor('#0CBABA')],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,  vertical: 130),
          child: Form(
            key: fkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('OTP Verification', style: TextStyle(fontSize: 20, color: Colors.white),),
                SizedBox(height: 5),
                Text('An otp has been sent to \'+91${data[1].toString()}\'', style: TextStyle(color: Colors.grey)),
                PinCodeTextField(textStyle: TextStyle(color: Colors.white),pinTheme: PinTheme(
                  inactiveColor: Colors.grey,
                  selectedColor: Colors.yellow,
                  activeColor: Colors.white,
                ),appContext: context, length: 6, onSaved: (newValue) => otp = newValue, keyboardType: TextInputType.number, onChanged: (value) => print(value), backgroundColor: Colors.transparent,),
                Row(
                  children: [Expanded(
                                      child: RaisedButton(onPressed: ()async{
                      print(data[0]);
                      if(fkey.currentState.validate()){
                        fkey.currentState.save();
                         PhoneAuthCredential cred = PhoneAuthProvider.credential(verificationId: data[0], smsCode: otp);
                      await FirebaseAuth.instance.signInWithCredential(cred);
                      Navigator.of(context).pushNamedAndRemoveUntil('/landingScreen', (Route<dynamic> route) => false);
                      }
                     
                    }, child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text("Verify"),
                    ),),
                  )],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}