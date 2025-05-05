import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  Logout({super.key});

  final GlobalKey<FormState> formState = GlobalKey();

  String? name;
  String? pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                // Text("Log out page", style: TextStyle(
                //   fontSize: 14,
                //   fontWeight:FontWeight.bold
                // ),
                // ),
                Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              // FIRST NAME
                              child:TextFormField(
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
                                hintText: "First name",
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                prefixIcon: Icon(Icons.person)
                              ),
                            ), 
                              ),
                        
                                SizedBox(width: 5,),
                              // LAST NAME
                              Expanded(
                              // FIRST NAME
                              child:TextFormField(
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
                                hintText: "Last name",
                                hintStyle: TextStyle(color: Colors.grey[500]),
                              ),
                            ), 
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
