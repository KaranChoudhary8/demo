import 'package:expense/Provider/add_amount_provider.dart';
import 'package:expense/Provider/auth_service.dart';
import 'package:expense/Provider/date_time.dart';
import 'package:expense/Provider/fetch_record.dart';
import 'package:expense/Provider/radio_picker.dart';
import 'package:expense/Screens/otp_receiever.dart';
import 'package:expense/Settings/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/mobile_register.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => DateTimeProvider()),
        ChangeNotifierProvider(create: (_) => RadioPicker()),
        ChangeNotifierProvider(create: (_) => AddAmountProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),

        home: Wrapper(),
        // home: const HomePage(),
      ),
    );
  }
}
