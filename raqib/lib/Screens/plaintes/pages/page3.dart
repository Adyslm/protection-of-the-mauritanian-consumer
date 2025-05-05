import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

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
            // margin: EdgeInsets.symmetric(horizontal: 20),
            child:Text("""
              - Via l'application mobile
              - En appelant notre hotline au 19588 
              - Par fax au 0233055703
              - Via notre site web https://cpa.gov.eg
              - Via WhatsApp au 01577779999
            """,
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