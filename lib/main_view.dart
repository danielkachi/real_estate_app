import 'package:flutter/material.dart';
import 'package:real_estate_app/nest/nav_bar.dart';
import 'package:real_estate_app/screens/favorite/favorite_screen.dart';
import 'package:real_estate_app/screens/home/home_screen.dart';
import 'package:real_estate_app/screens/messaging/messaging_screen.dart';
import 'package:real_estate_app/screens/profile/profile_screen.dart';
import 'package:real_estate_app/screens/search/search_screen.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  int _selectedIndex = 2;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late AnimationController _sliderController;
  late Animation<double> _sliderAnimation;

  final List<Widget> _screens = [
    const SearchScreen(tab: 1),
    const MessagingScreen(tab: 2),
    const HomeScreen(tab: 3),
    const FavoriteScreen(tab: 4),
    const ProfileScreen(tab: 5),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _sliderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _sliderAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
        CurvedAnimation(parent: _sliderController, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
      _sliderController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _sliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: AnimatedBuilder(
            animation: _sliderAnimation,
            builder: (context, child) {
              return _screens[_selectedIndex];
            },
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _slideAnimation,
              child: NavBar(
                pageIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
