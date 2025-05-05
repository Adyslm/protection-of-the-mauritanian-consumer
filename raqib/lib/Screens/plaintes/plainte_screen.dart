import 'package:flutter/material.dart';
import 'package:raqib/Screens/plaintes/chef_local/Login_screen_chef.dart';
import 'package:raqib/Screens/plaintes/declare_plainte.dart';
import 'package:raqib/Screens/plaintes/pages/page1.dart';
import 'package:raqib/Screens/plaintes/pages/page2.dart';
import 'package:raqib/Screens/plaintes/pages/page3.dart';
import 'package:raqib/Screens/plaintes/savoir_plainte.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlainteScreen extends StatelessWidget {
  const PlainteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consumer Protection Complaints',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily:
            'Arial', // You might want to use a more appropriate Arabic font
      ),
      home: const ComplaintScreen(),
    );
  }
}

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final PageController _controller =
      PageController(); // Declare and initialize here.

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF283593), // Dark blue background
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          100.0,
        ), // Increased height for curve
        child: ClipPath(
          clipper: CurvedBottomClipper(),
          child: Container(
            color: const Color.fromARGB(255, 45, 205, 9),
            child: const Center(
              child: Text(
                'الشكاوى',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Added SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Reduced padding
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Changed to start
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 10.0),
                const Text(
                  "Bienvenue au système de plaintes 📣",

                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        Colors
                            .black, // Changed to black for better visibility on white background
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32.0),
                //=====================================
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 300, // Increased height to show the pages.
                      child: PageView(
                        controller: _controller,
                        children: const [
                          // Added const here since the pages don't rebuild.
                          Page1(),
                          Page2(),
                          Page3(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: JumpingDotEffect(
                        activeDotColor: Colors.deepOrange,
                        dotColor: Colors.deepPurple.shade100,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 10,
                      ),
                      //  axisDirection: ,
                    ),
                  ],
                ),

                const SizedBox(height: 40.0),
                const Text(
                  "Inscrivez-vous ou connectez-vous pour pouvoir déposer ou suivre une plainte. ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black, // Changed to black
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChefLoginScreen(),
                              ),
                            );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFBDBDBD,
                          ), // Grey button
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: const Text(
                          "S'INSCRIRE",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement action for login
                          print('تسجيل دخول pressed');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeclarePlainte(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF5C6BC0,
                          ), // Lighter blue button
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        child: const Text(
                          "DEPOSER",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40); // Start at bottom left
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    ); // Curve
    path.lineTo(size.width, 0); // Line to top right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
