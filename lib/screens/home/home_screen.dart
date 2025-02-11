import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_estate_app/screens/home/widgets/custom_bottom_sheet.dart';
import 'package:real_estate_app/utils/app_text.dart';
import 'package:real_estate_app/utils/color_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.tab}) : super(key: key);

  final int tab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _locationSlideAnimation;
  late Animation<double> _locationFadeAnimation;
  late Animation<double> _avatarScaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Animation duration
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Starts below the screen
      end: const Offset(0, 0), // Moves to original position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0, // Starts completely transparent
      end: 1.0, // Becomes fully visible
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _locationSlideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0), // Starts from left
      end: const Offset(0, 0), // Moves to original position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _locationFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start animation when screen opens
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });

    _avatarScaleAnimation = Tween<double>(
      begin: 0.5, // Starts at half size
      end: 1.0, // Ends at normal size
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorClass.appHomeCream.withOpacity(0.2),
                  ColorClass.appHomeCream.withOpacity(0.2),
                  ColorClass.appHomeCream.withOpacity(0.2),
                  ColorClass.appHomeCream.withOpacity(0.9),
                  ColorClass.appHomeCream.withOpacity(0.9),
                  ColorClass.appOrangeAccent.withOpacity(0.5),
                  ColorClass.appOrangeAccent.withOpacity(0.5),
                  ColorClass.appOrangeAccent.withOpacity(0.5),
                  ColorClass.appOrangeAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24).copyWith(top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return SlideTransition(
                            position: _locationSlideAnimation,
                            child: FadeTransition(
                              opacity: _locationFadeAnimation,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.place,
                                      color: ColorClass.appGrey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Saint Petersburg",
                                      style: AppText.regular.copyWith(
                                        color: ColorClass.appGrey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      ScaleTransition(
                        scale: _avatarScaleAnimation,
                        child: const CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          radius: 28,
                          backgroundImage: NetworkImage(
                            "https://media.istockphoto.com/id/488312318/photo/young-blond-woman-laughing.jpg?s=612x612&w=0&k=20&c=zdgEglF8YA-6q0a-2c_pMTB26f7NSS6dY0Y-GRM6QZY=",
                          ),
                        ),
                      ),
                    ],
                  ),

                  // SLIDING TEXT ANIMATION
                  const SizedBox(height: 50),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi, Marina",
                                    style: AppText.regular.copyWith(
                                      color: ColorClass.appGrey,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "let's select your\nperfect place",
                                    style: AppText.regular.copyWith(
                                      color: ColorClass.appBlack,
                                      fontSize: 38,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // BUY CARD
                                      Expanded(
                                        child: Card(
                                          elevation: 0,
                                          color: ColorClass.appOrange,
                                          shape: const CircleBorder(),
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              minWidth: 150,
                                              minHeight: 150,
                                              maxWidth: 200,
                                              maxHeight: 200,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 30),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "BUY",
                                                    style: AppText.semiBold
                                                        .copyWith(
                                                      color:
                                                          Colors.yellow.shade50,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 25),
                                                  TweenAnimationBuilder<int>(
                                                    tween: IntTween(
                                                        begin: 900, end: 1034),
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    builder: (context, value,
                                                        child) {
                                                      final formattedValue =
                                                          NumberFormat("#,###",
                                                                  "en_US")
                                                              .format(value)
                                                              .replaceAll(
                                                                  ",", " ");
                                                      return Text(
                                                        formattedValue,
                                                        style: AppText.bold
                                                            .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 40,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Text(
                                                    "offers",
                                                    style: AppText.semiBold
                                                        .copyWith(
                                                      color:
                                                          Colors.yellow.shade50,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // RENT CARD
                                      Expanded(
                                        child: Card(
                                          color: ColorClass.appOffWhite,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              minWidth: 150,
                                              minHeight: 150,
                                              maxWidth: 200,
                                              maxHeight: 175,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 30),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "RENT",
                                                    style: AppText.semiBold
                                                        .copyWith(
                                                      color: ColorClass.appGrey,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 25),
                                                  TweenAnimationBuilder<int>(
                                                    tween: IntTween(
                                                        begin: 2000, end: 2212),
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    builder: (context, value,
                                                        child) {
                                                      final formattedValue =
                                                          NumberFormat("#,###",
                                                                  "en_US")
                                                              .format(value)
                                                              .replaceAll(
                                                                  ",", " ");
                                                      return Text(
                                                        formattedValue,
                                                        style: AppText.bold
                                                            .copyWith(
                                                          color: ColorClass
                                                              .appGrey,
                                                          fontSize: 40,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  Text(
                                                    "offers",
                                                    style: AppText.semiBold
                                                        .copyWith(
                                                      color: ColorClass.appGrey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ])),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Bottom Sheet
          const CustomBottomSheet(),
        ],
      ),
    );
  }
}
