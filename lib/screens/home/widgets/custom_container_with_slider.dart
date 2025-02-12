import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/app_text.dart';
import 'package:real_estate_app/utils/color_class.dart';

class CustomContainerWithSlider extends StatefulWidget {
  final String imageUrl;
  final double height;
  final String sliderText;
  final bool autoSlide;
  final VoidCallback? onBottomSheetOpened;

  const CustomContainerWithSlider({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.sliderText,
    this.autoSlide = false,
    this.onBottomSheetOpened,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomContainerWithSliderState createState() =>
      _CustomContainerWithSliderState();
}

class _CustomContainerWithSliderState extends State<CustomContainerWithSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sliderAnimation;
  bool isUnlocked = false;
  double containerWidth = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _sliderAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant CustomContainerWithSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoSlide && !oldWidget.autoSlide) {
      startSliderAnimation();
    }
  }

  void startSliderAnimation() {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          containerWidth = context.size?.width ?? 0;
          _sliderAnimation = Tween<double>(
            begin: 0.0,
            end: containerWidth - 60,
          ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
            ..addListener(() {
              if (_sliderAnimation.value >= containerWidth - 100) {
                setState(() {
                  isUnlocked = true;
                });
              }
            });
          _controller.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        containerWidth = constraints.maxWidth;

        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: ColorClass.appSlider.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _sliderAnimation,
                        builder: (context, child) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Transform.translate(
                              offset: Offset(_sliderAnimation.value, 0),
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: const BoxDecoration(
                                  color: ColorClass.appOffWhite,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: ColorClass.appSlider,
                                  size: 20,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      if (isUnlocked)
                        Center(
                          child: Text(
                            widget.sliderText,
                            style:
                                AppText.regular.copyWith(color: Colors.black),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
