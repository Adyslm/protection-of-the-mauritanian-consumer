import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:raqib/Screens/field_otp.dart';
//import 'package:raqib/Screens/home_screen.dart';
// import 'package:raqib/Screens/login_screen.dart';
import 'package:raqib/Screens/register_screen.dart';

class OPT_Page extends StatelessWidget {
  const OPT_Page({super.key});

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    // final phoneNumber = ModalRoute.of(context)!.settings.arguments as String;
    // final name = ModalRoute.of(context)!.settings.arguments as String;

    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final phoneNumber = args['phoneNumber'] as String;
    final name = args['name'] as String;

    // String Name = name;
    final List<TextEditingController> controllers = List.generate(
      4,
      (index) => TextEditingController(),
    );
    //========
    String _formatPhoneNumber(String phone) {
      if (phone.length < 4) return phone; // Cas des numéros trop courts

      final cleanPhone = phone.replaceAll(
        RegExp(r'[^0-9]'),
        '',
      ); // Nettoyage des caractères non numériques
      final start = cleanPhone.substring(0, 2);
      final end = cleanPhone.substring(cleanPhone.length - 2);
      final masked = '${start}${'*' * (cleanPhone.length - 4)}$end';

      // Ajout d'espaces pour une meilleure lisibilité
      return masked.replaceAllMapped(
        RegExp(r'.{2}'),
        (match) => '${match.group(0)} ',
      );
    }
    //========

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("OTP"),
        backgroundColor: Colors.blue[400],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Verification",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Enter the code send to:",
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _formatPhoneNumber(phoneNumber),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: heightScreen * .04),
                  // Passez les contrôleurs à OPtWidget
                  OPtWidget(controllers: controllers),
                  SizedBox(height: heightScreen * .03),
                  Padding(
                    padding: const EdgeInsets.only(left: 22, right: 22),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Concaténer les valeurs des 4 champs
                          String otpCode =
                              controllers.map((c) => c.text).join();

                          // Vérifier si le code est "0000"
                          if (otpCode == "0000") {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const HomeScreen(),
                            //   ),
                            // );
                            //===========================================
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'Register successfuly',
                              desc:
                                  'This informations ars register successfuly',
                              //btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                    settings: RouteSettings(
                                      arguments: {
                                        'phoneNumber': phoneNumber,
                                        'name': name,
                                      },
                                    ),
                                  ),
                                );
                              },
                            )..show();
                            //============================================
                          } else {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text('Code OTP incorrect'),
                            //     backgroundColor: Colors.red,
                            //   ),
                            // );
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'Failed to register',
                              desc: 'This informations was non registred!',
                              //btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            )..show();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Color(0xff985adb),
                        ),
                        child: Text(
                          "VERIFY",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightScreen * .02),
                  Text(
                    "Reset code?",
                    style: TextStyle(color: Color(0xff985adb), fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
