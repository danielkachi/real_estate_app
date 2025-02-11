import 'package:flutter/material.dart';
import 'package:real_estate_app/screens/home/widgets/custom_container_with_slider.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.38,
      minChildSize: 0.38,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(8),
            children: [
              const CustomContainerWithSlider(
                imageUrl:
                    "https://media.istockphoto.com/id/1189096836/photo/upper-living-room-view-on-to-garden-pool-and-courtyard-of-spanish-farmhouse-barcelona.webp?a=1&b=1&s=612x612&w=0&k=20&c=7Q8lGHwnLM_mOr5fAjXL5L80vFb60Ibnt-tSS0kDmgk=",
                height: 200,
                sliderText: "Gladkova St., 25",
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomContainerWithSlider(
                      imageUrl:
                          "https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?w=800&auto=format&fit=crop&q=60",
                      height: MediaQuery.of(context).size.height * 0.4,
                      sliderText: "Gubina St., 11",
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        CustomContainerWithSlider(
                          imageUrl:
                              "https://images.unsplash.com/photo-1516455207990-7a41ce80f7ee?w=800&auto=format&fit=crop&q=60",
                          height: MediaQuery.of(context).size.height * 0.195,
                          sliderText: "Trefoleva., 43",
                        ),
                        const SizedBox(height: 8),
                        CustomContainerWithSlider(
                          imageUrl:
                              "https://media.istockphoto.com/id/1213695544/photo/3d-rendering-of-a-luxurious-bedroom-interior.webp?a=1&b=1&s=612x612&w=0&k=20&c=3tTK0TkiLPGXRpZMgtwQ4fK0q0cRKbaigK0Ll9VT0ak=",
                          height: MediaQuery.of(context).size.height * 0.195,
                          sliderText: "Sedova St., 22",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
