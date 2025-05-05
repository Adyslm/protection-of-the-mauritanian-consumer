import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:raqib/Screens/plaintes/chef_local/Login_screen_chef.dart';
import 'package:raqib/Screens/plaintes/chef_local/notification_plainte.dart';
import 'package:raqib/Screens/plaintes/chef_local/personal.dart';
import 'package:raqib/Screens/plaintes/chef_local/settings.dart';
import 'package:raqib/Services/chef_services.dart';

class HomeScreenChef extends StatefulWidget {
  const HomeScreenChef({super.key});

  @override
  State<HomeScreenChef> createState() => _HomeScreenChefState();
}

class _HomeScreenChefState extends State<HomeScreenChef> {
  int _currentIndex = 0;
  String chefName = 'Chargement...';
  String moughataa = 'Chargement...';
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchChefData();
  }

  Future<void> _fetchChefData() async {
  setState(() {
    isLoading = true;
    errorMessage = '';
  });

  try {
    final result = await ChefServices.getAuthenticatedChef();
    if (result['success'] == true) {
      setState(() {
        chefName = result['data']['name'] ?? 'Nom non disponible';
        moughataa = result['data']['moughataa'] ?? 'Moughataa non disponible';
        isLoading = false;
      });
    } else {
      throw Exception('Données non reçues');
    }
  } catch (e) {
    setState(() {
      errorMessage = e.toString().replaceAll('Exception: ', '');
      isLoading = false;
    });
    debugPrint('Erreur fetchChefData: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: ClipPath(
            clipper: CurvedBottomClipper(),
            child: Container(
              color: const Color.fromARGB(255, 129, 64, 178),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://via.placeholder.com/40',
                            ),
                            radius: 30,
                          ),
                          const SizedBox(width: 12.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                chefName,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                moughataa,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[200],
                                ),
                              ),
                              if (errorMessage.isNotEmpty)
                                Text(
                                  errorMessage,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.red,
                                  ),
                                ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.message,
                              color: Color.fromARGB(255, 24, 36, 41),
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.notifications,
                              color: Color.fromARGB(255, 24, 36, 41),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationPlainte(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body:
            isLoading
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      Text(
                        'Chargement en cours...',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      if (errorMessage.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                )
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                          children: <Widget>[
                            _buildDashboardCard(
                              context: context,
                              title: 'Visitors',
                              icon: Icons.people_outline,
                              gradientColors: const [
                                Color.fromARGB(255, 93, 203, 150),
                                Color.fromARGB(255, 222, 152, 12),
                              ],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChefLoginScreen(),
                                  ),
                                );
                              },
                            ),
                            _buildDashboardCard(
                              context: context,
                              title: 'MOM',
                              icon: Icons.meeting_room_outlined,
                              gradientColors: const [
                                Color.fromARGB(255, 71, 60, 59),
                                Color(0xFFff5722),
                              ],
                              onTap: () {},
                            ),
                            _buildDashboardCard(
                              context: context,
                              title: 'Help Desk',
                              icon: Icons.question_answer_outlined,
                              gradientColors: const [
                                Color(0xFF2196f3),
                                Color(0xFF03a9f4),
                              ],
                              onTap: () {},
                            ),
                            _buildDashboardCard(
                              context: context,
                              title: 'Amenities',
                              icon: Icons.location_on_outlined,
                              gradientColors: const [
                                Color(0xFF4caf50),
                                Color(0xFF8bc34a),
                              ],
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Personal',
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.blue,
          onTap: (int index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Personal()),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Color> gradientColors,
    required VoidCallback? onTap,
  }) {
    final Color startColor =
        gradientColors.isNotEmpty ? gradientColors.first : Colors.grey;
    final Color endColor =
        gradientColors.length > 1 ? gradientColors.last : startColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: endColor.withOpacity(0.2),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(icon, size: 40.0, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
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
    path.lineTo(0, size.height - 5);
    path.quadraticBezierTo(
      size.width / 1,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
