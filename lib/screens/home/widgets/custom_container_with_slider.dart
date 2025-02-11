import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/app_text.dart';
import 'package:real_estate_app/utils/color_class.dart';

class CustomContainerWithSlider extends StatefulWidget {
  final String imageUrl;
  final double height;
  final String sliderText;

  const CustomContainerWithSlider({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.sliderText,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomContainerWithSliderState createState() =>
      _CustomContainerWithSliderState();
}

class _CustomContainerWithSliderState extends State<CustomContainerWithSlider> {
  double sliderPosition = 0.0;
  bool isUnlocked = false;
  double containerWidth = 0.0;

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
                      GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          setState(() {
                            sliderPosition += details.delta.dx;
                            sliderPosition =
                                sliderPosition.clamp(0.0, containerWidth - 60);

                            if (sliderPosition >= containerWidth - 100) {
                              isUnlocked = true;
                            }
                          });
                        },
                        onHorizontalDragEnd: (_) {
                          if (!isUnlocked) {
                            setState(() {
                              sliderPosition = 0.0;
                            });
                          }
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Transform.translate(
                            offset: Offset(sliderPosition, 0),
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
                        ),
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
