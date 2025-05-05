import 'package:flutter/material.dart';
// import 'package:raqib/components/my_button.dart';
// import 'package:raqib/components/my_textField.dart';
import 'package:raqib/log/logout.dart';
import 'package:raqib/pages/home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final nameController = TextEditingController();
  final passController = TextEditingController();

  String? name;
  String? pass;


  // void signUserIn(BuildContext context) {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => Hame_Page()),
  //   );
  // }

  final GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  Icon(Icons.lock, size: 116),
                  //Image.asset('lib/images/google.png'),
                  SizedBox(height: 50),

                  SizedBox(height: 25),

                  // Username input
                  Form(
                    key: formState,
                    child: Column(
                      children: [
                        // USER NAME INPUT
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            onSaved: (vall) {
                              pass = vall;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Le champ et vide";
                              }
                              return null;
                            },
                            //controller: nameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ),

                        SizedBox(height: 13),

                        // PASSWORD INPUT
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            onSaved: (vall) {
                              name = vall;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return null;
                              }
                              if (value.length < 4) {
                                return "length invalid!";
                              }
                              return null;
                            },
                            //controller: nameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  //
                  //const SizedBox(height: 10),

                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // BOUTTON
                  TextButton(
                    onPressed: () {
                      if (formState.currentState!.validate()) {
                        formState.currentState!.save(); 
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Hame_Page(),
                            ),
                          );
                      }
                      else{
                        print("=================================================================");
                      print("invalid");
                      }
                      
                      
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey.shade200,
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 45,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      textStyle: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Signe In'),
                  ),

                  const SizedBox(height: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text("No registred?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Logout()),
                          );
                        },
                        child: Text(
                          "create an account",
                          style: TextStyle(
                            color: Colors.grey[700],
                            //fontSize: 13
                            ),
                        ),
                      ),
                    ],
                  ),

                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
