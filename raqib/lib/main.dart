import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raqib/Screens/home_screen.dart';
import 'package:raqib/Screens/login_screen.dart';
import 'package:raqib/Screens/plaintes/chef_local/Login_screen_chef.dart';
import 'package:raqib/Screens/plaintes/chef_local/home_screen_chef.dart';
import 'package:raqib/Screens/plaintes/chef_local/register_screen_chef.dart';
// import 'package:raqib/Screens/auth.dart';
// import 'package:raqib/Screens/home_screen.dart';
// import 'package:raqib/Screens/login_screen.dart';
import 'package:raqib/Screens/plaintes/declare_plainte.dart';
import 'package:raqib/Screens/plaintes/plainte_screen.dart';
import 'package:raqib/provider/chef_notification.dart';
// import 'package:raqib/Screens/plaintes/location.dart';
// import 'package:raqib/Screens/plaintes/plainte_screen.dart';
// import 'package:raqib/Screens/plaintes/savoir_plainte.dart';
// import 'package:raqib/Screens/register_screen.dart';
//import 'package:raqib/Screens/login_screen.dart';
//import 'package:raqib/Screens/otp.dart';
//import 'package:raqib/Screens/login_screen.dart';
//import 'package:raqib/Screens/register_screen.dart';
//import 'package:raqib/Screens/login_screen.dart';
//import 'package:raqib/Screens/register_screen.dart';
//import 'package:raqib/log/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 
  const MyApp({super.key});
   
  @override
  Widget build(BuildContext context) {
    
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ChefNotification(),
          ),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: LoginScreen()
    ),
      );
  }
}






