// import 'dart:async';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:raqib/Screens/login_screen.dart';
// import 'package:raqib/Screens/plaintes/declare_plainte.dart';
// import 'package:raqib/Screens/plaintes/plainte_screen.dart';
// import 'package:raqib/Screens/register_screen.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   late PageController _pageController;
//   late Timer _timer;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _currentPage);
//     _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
//       if (_currentPage < 2) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//       _changePage(_currentPage);
//     });
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _timer.cancel();
//     super.dispose();
//   }

//   void _changePage(int page) {
//     if (_pageController.hasClients) {
//       _pageController.animateToPage(
//         page,
//         duration: Duration(milliseconds: 350),
//         curve: Curves.easeIn,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               child: PageView(
//                 controller: _pageController,
//                 children: [
//                   // Icon(Icons.person, size: 100),
//                   // Icon(Icons.woman, size: 100),
//                   // Icon(Icons.child_care, size: 100),
//                   // Image.asset("images/google.png"),
//                   Container(
//                     width: double.infinity, // Prend toute la largeur disponible
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment:
//                           CrossAxisAlignment
//                               .stretch, // Étire les enfants horizontalement
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(
//                             12,
//                           ), // Arrondi les coins de l'image
//                           // child: Image.asset(
//                           //   "images/G.jpg",
//                           //   fit:
//                           //       BoxFit
//                           //           .cover, // Couvre toute la largeur en conservant le ratio
//                           //   height: 200, // Hauteur fixe pour l'image
//                           // ),
//                         ),
//                         const SizedBox(height: 20), // Espacement
//                         Container(
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(
//                               0.9,
//                             ), // Fond semi-transparent
//                             borderRadius: BorderRadius.circular(
//                               12,
//                             ), // Coins arrondis
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.3),
//                                 spreadRadius: 2,
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: Text(
//                             """La direction de la protection des consommateurs et de la répression des fraudes
//           relevant du ministère du Commerce, de l’Industrie, de l’Artisanat et du Tourisme
//           a fait parvenir ce mercredi à l’AMI, le rapport annuel de son action pour l’année 2022.""",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey[800],
//                               height: 1.4, // Interligne
//                               fontFamily:
//                                   'Roboto', // Utilise une police personnalisée
//                               shadows: [
//                                 Shadow(
//                                   blurRadius: 2,
//                                   color: Colors.white.withOpacity(0.5),
//                                   offset: const Offset(1, 1),
//                                 ),
//                               ],
//                             ),
//                             textAlign:
//                                 TextAlign.justify, // Justification du texte
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                   // Image.asset("images/google.png"),
//                   // Image.asset("images/google.png"),
//                 ],
//                 onPageChanged: (page) {
//                   setState(() {
//                     _currentPage = page;
//                   });
//                 },
//               ),
//             ),
//           ),
//           //Image.asset("images/google.png"),
//         ],
//       ),
//       //backgroundColor: Colors.blue,
//       bottomNavigationBar: ConvexAppBar(
//         items: [
//           TabItem(icon: Icon(Icons.edit_document), title: "Documents"),
//           TabItem(icon: Icon(Icons.newspaper), title: "Actualités"),
//           TabItem(icon: Icon(Icons.warning), title: "Signaler"),
//           TabItem(icon: Icon(Icons.menu), title: "Menu"),
//         ],
//         initialActiveIndex: _currentIndex,
//         backgroundColor: Colors.green,
//         activeColor: Colors.white,
//         color: Colors.black,
//         height: 70,
//         curve: Curves.bounceInOut,
//         onTap: _changeItem,
//       ),
//     );
//   }

//   void _changeItem(int index) {
//     setState(() {
//       _currentIndex = index;
//     });

//     switch (index) {
//       case 0:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => DeclarePlainte()),
//         );
//         break;
//       case 1:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => RegisterScreen()),
//         );
//         break;
//       case 2:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => PlainteScreen()),
//         );
//         break;
//       case 3:
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => RegisterScreen()),
//         );
//         break;
//     }
//   }
// }

//=========================================================================================================
// import 'dart:async';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:flutter/material.dart';
// // import 'package:raqib/Screens/login_screen.dart';
// import 'package:raqib/Screens/plaintes/declare_plainte.dart';
// import 'package:raqib/Screens/plaintes/plainte_screen.dart';
// import 'package:raqib/Screens/register_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   late final PageController _pageController;
//   late final Timer _timer;
//   int _currentPage = 0;

//   // Configuration des pages du carousel
//   final List<Widget> _carouselPages = [
//     // Image.asset("images/google.png"),
//     _buildNewsCard(),
//     // Image.asset("images/google.png"),
//     // Image.asset("images/google.png"),
//   ];

//   // Configuration des items de la barre de navigation
//   final List<Map<String, dynamic>> _navItems = [
//     {
//       'icon': Icons.edit_document,
//       'label': "Documents",
//       'route': (context) =>  DeclarePlainte(),
//     },
//     {
//       'icon': Icons.newspaper,
//       'label': "Actualités",
//       'route': (context) =>  RegisterScreen(),
//     },
//     {
//       'icon': Icons.warning,
//       'label': "Signaler",
//       'route': (context) => const PlainteScreen(),
//     },
//     {
//       'icon': Icons.menu,
//       'label': "Menu",
//       'route': (context) =>  RegisterScreen(),
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _currentPage);
//     _timer = Timer.periodic(const Duration(seconds: 3), _handleTimerTick);
//   }

//   void _handleTimerTick(Timer timer) {
//     setState(() {
//       _currentPage = (_currentPage + 1) % _carouselPages.length;
//       _changePage(_currentPage);
//     });
//   }

//   void _changePage(int page) {
//     if (_pageController.hasClients) {
//       _pageController.animateToPage(
//         page,
//         duration: const Duration(milliseconds: 350),
//         curve: Curves.easeIn,
//       );
//     }
//   }

//   void _changeItem(int index) {
//     setState(() => _currentIndex = index);
//     Navigator.push(context, MaterialPageRoute(builder: _navItems[index]['route']));
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Accueil'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView(
//               controller: _pageController,
//               children: _carouselPages,
//               onPageChanged: (page) => setState(() => _currentPage = page),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: ConvexAppBar(
//         items: _navItems
//             .map((item) => TabItem(icon: Icon(item['icon']), title: item['label']))
//             .toList(),
//         initialActiveIndex: _currentIndex,
//         backgroundColor: Colors.green,
//         activeColor: Colors.white,
//         color: Colors.black,
//         height: 70,
//         curve: Curves.bounceInOut,
//         onTap: _changeItem,
//       ),
//     );
//   }

//   // Méthode pour construire la carte d'actualités
//   static Widget _buildNewsCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.asset(
//               "images/G.jpg",
//               fit: BoxFit.cover,
//               height: 200,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.9),
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.3),
//                   spreadRadius: 2,
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: const Text(
//               """La direction de la protection des consommateurs et de la répression des fraudes
// relevant du ministère du Commerce, de l'Industrie, de l'Artisanat et du Tourisme
// a fait parvenir ce mercredi à l'AMI, le rapport annuel de son action pour l'année 2022.""",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//                 height: 1.4,
//                 fontFamily: 'Roboto',
//               ),
//               textAlign: TextAlign.justify,
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
//=======================================================================================================


import 'dart:async';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:raqib/Screens/login_screen.dart';
import 'package:raqib/Screens/plaintes/declare_plainte.dart';
import 'package:raqib/Screens/plaintes/plainte_screen.dart';
import 'package:raqib/Screens/register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late Timer _textTimer;
  int _currentTextIndex = 0;
  final List<String> _scrollingTexts = [
    "Actualité 1: Nouvelle campagne de sensibilisation en cours",
    "Actualité 2: Réunion du conseil municipal prévue demain à 10h",
    "Actualité 3: Travaux de voirie sur la rue principale cette semaine",
    "Actualité 4: Inscriptions aux activités culturelles ouvertes",
    "Actualité 5: Nouveau service de déclaration en ligne disponible",
  ];

  @override
  void initState() {
    super.initState();
    // Timer pour le texte défilant
    _textTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      setState(() {
        _currentTextIndex = (_currentTextIndex + 1) % _scrollingTexts.length;
      });
    });
  }

  @override
  void dispose() {
    _textTimer.cancel();
    super.dispose();
  }

  void _changeItem(int index) {
    setState(() => _currentIndex = index);
    
    final routes = [
      () =>  DeclarePlainte(),
      () =>  RegisterScreen(),
      () => const PlainteScreen(),
      () =>  RegisterScreen(),
    ];
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => routes[index]()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Conteneur pour le texte défilant
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: Text(
                  _scrollingTexts[_currentTextIndex],
                  key: ValueKey<int>(_currentTextIndex),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Icône principale
            const Icon(
              Icons.home,
              size: 80,
              color: Colors.green,
            ),
            
            const SizedBox(height: 20),
            
            // Texte descriptif
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Bienvenue sur l'application Raqib. Utilisez le menu en bas pour naviguer.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icon(Icons.edit_document), title: "Documents"),
          TabItem(icon: Icon(Icons.newspaper), title: "Actualités"),
          TabItem(icon: Icon(Icons.warning), title: "Signaler"),
          TabItem(icon: Icon(Icons.menu), title: "Menu"),
        ],
        initialActiveIndex: _currentIndex,
        backgroundColor: Colors.green,
        activeColor: Colors.white,
        color: Colors.black,
        height: 70,
        curve: Curves.bounceInOut,
        onTap: _changeItem,
      ),
    );
  }
}