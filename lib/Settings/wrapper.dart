import 'package:expense/Provider/auth_service.dart';
import 'package:expense/Screens/home.dart';
import 'package:expense/Screens/mobile_register.dart';
import 'package:expense/Settings/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<MyUser?>(
        stream: authService.user, builder: (_, AsyncSnapshot<MyUser?> snap){
          if (snap.connectionState == ConnectionState.active){
            final MyUser? user = snap.data;
            return user == null ? MobileRegister() : HomePage();
          }
          else{
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          }
    });
  }
}
