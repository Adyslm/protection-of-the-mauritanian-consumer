import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Padding(padding: const EdgeInsets.all(40.0),
      // child: ClipRRect(
      //   borderRadius: BorderRadius.circular(10),
        //child: Colors.white,
      // ),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset("images/L.png",fit: BoxFit.cover,height: 100,),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 28),
            child:Text("Si vous souhaitez déposer une plainte directement auprès de l'Agence de Protection du Consommateur, vous pouvez le faire de l'une des manières suivantes :",
            style: TextStyle(
              // inherit: true,
              fontSize: 15.0,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          // Image.asset("images/google")
        ],
      ),
    );
  }
}