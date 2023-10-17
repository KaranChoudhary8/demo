import 'package:expense/Provider/auth_service.dart';
import 'package:expense/Screens/otp_receiever.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CustomW/custom_input.dart';

class MobileRegister extends StatefulWidget {
  const MobileRegister({super.key});

  @override
  State<MobileRegister> createState() => _MobileRegisterState();
}

class _MobileRegisterState extends State<MobileRegister> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController mobileController = TextEditingController();
    final authServices = Provider.of<AuthService>(context);
    final _firebasAuth = FirebaseAuth.instance;
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome.",
                style: TextStyle(fontSize: 46, fontWeight: FontWeight.w600),
              ),
              Text("Enter your Mobile number with country code to continue"),
              SizedBox(
                height: 20,
              ),
              MyInput(label: "Mobile",hint: "+91 XXXXXXXXXX", icon: Icons.phone, controller: mobileController,),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (mobileController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Mobile Number"),));
                  }
                  else{
                    await _firebasAuth.verifyPhoneNumber(
                      phoneNumber: mobileController.text,
                      verificationCompleted: (PhoneAuthCredential credential) {

                      },
                      verificationFailed: (FirebaseAuthException e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong"),));
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpReceiver(verificationId: verificationId,)));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                  }
                },
                child: Text("Continue"),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              )
            ],
          ),
        ),
      ),
    );
  }
}


