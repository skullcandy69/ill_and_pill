import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:html' as html;

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({super.key});

  @override
  _ComingSoonPageState createState() => _ComingSoonPageState();
}

class _ComingSoonPageState extends State<ComingSoonPage>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOut,
      ),
    );

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/background.jpg'), // Your background image here
                  fit: BoxFit.cover,
                  opacity: 0.5),
            ),
            child: Container(
              color: Colors.black.withOpacity(
                  0.3), // Adding a dark overlay for better text visibility
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: const Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                              'assets/logo.jpeg'), // Your pharmacy logo here
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Coming Soon',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'A UNIT OF HEALX AAROGYAM PVT. LTD.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Opening at M3M 65th Avenue, R3 LG-37',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIconButton(
                        FontAwesomeIcons.instagram,
                        Colors.purpleAccent,
                        "https://www.instagram.com/illandpill/"),
                    _buildIconButton(Icons.email, Colors.redAccent,
                        "mailto:support@illandpill.com"),
                    _buildIconButton(Icons.location_on, Colors.green,
                        "https://maps.app.goo.gl/SUk9Fi5UWBwVFKLy9"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color iconColor, String url) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: const BoxDecoration(
          color: Colors.white, // White background for the icon button
          shape: BoxShape.circle, // Circular shape
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: FaIcon(icon,
              color: iconColor), // Using FaIcon for FontAwesome icons
          onPressed: () => html.window.open(url, '_blank'),
        ));
  }
}
