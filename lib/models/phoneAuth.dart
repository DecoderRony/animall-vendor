import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Authorize {
  var verId;
  var resendToken;
  Future<void> auth(var phoneNo, context) async {
    var phoneAuth = FirebaseAuth.instance;
    try{
    await phoneAuth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNo',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await phoneAuth.signInWithCredential(credential);
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/landingScreen', (Route<dynamic> route) => false);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        verId = verificationId;
        print("HOOOLLLLA");
        print(verId);
        Navigator.of(context)
            .pushNamed('/otpScreen', arguments: [verId, phoneNo]);
        // String smsCode = 'xxxx';

        // // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

        // // Sign the user in (or link) with the credential
        // await phoneAuth.signInWithCredential(phoneAuthCredential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
      timeout: Duration(seconds: 120),
    );
    }catch(error){
      print("Error");
      print(error);
    }
  }
}
