import 'dart:ui';

import 'package:expense/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class OtpReceiver extends StatefulWidget {
  final String verificationId;
  OtpReceiver({super.key, required this.verificationId});

  @override
  State<OtpReceiver> createState() => _OtpReceiverState(verificationId);
}

class _OtpReceiverState extends State<OtpReceiver> {
  final String verificationId;
  _OtpReceiverState(this.verificationId);
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final TextEditingController otpController = TextEditingController();

    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "OTP Verification.",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
              ),
              Text("We have send an OTP on the number"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: otpController,
                decoration: InputDecoration(hintText: "OTP",),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: () async {
                if (otpController.text.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter OTP"),));
                }
                else{
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpController.text);
                  await auth.signInWithCredential(credential);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

                }

              }, child: Text("Continue"), style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),),
              // TextButton(onPressed: (){}, child: Text("Resend"), style: TextButton.styleFrom(minimumSize: const Size.fromHeight(50)),)

            ],
          ),
        ),
      ),
    );
  }


}
