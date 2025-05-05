import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

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
            margin: EdgeInsets.symmetric(horizontal: 16),
            child:Text("D'abord, essayez de régler le problème directement là où vous avez fait l'achat. Si vous ne trouvez pas de solution, contactez l'association de consommateurs la plus proche. Ils pourront vous aider avant que vous ne fassiez une réclamation officielle.",
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