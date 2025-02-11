import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/app_text.dart';
import 'package:real_estate_app/utils/color_class.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, required this.tab}) : super(key: key);

  final int tab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Map View
          // const GoogleMap(
          //   initialCameraPosition: CameraPosition(
          //     target:
          //         LatLng(59.9342802, 30.3350986), // St. Petersburg coordinates
          //     zoom: 12,
          //   ),
          //   zoomControlsEnabled: false,
          // ),

          // Search Bar
          Positioned(
            top: 80,
            left: 16,
            right: 16,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Saint Petersburg",
                        hintStyle: AppText.regularBlack,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: ColorClass.appBlack,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 28,
                    child: IconButton(
                      icon: const Icon(Icons.tune, color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Controls (left)
          Positioned(
            bottom: 130,
            left: 40,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  mini: true,
                  backgroundColor: ColorClass.appGrey2,
                  child: const Icon(Icons.layers),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  onPressed: () {},
                  mini: true,
                  backgroundColor: ColorClass.appGrey2,
                  child: const Icon(Icons.navigation_rounded),
                ),
              ],
            ),
          ),

          // List of Variants Button
          Positioned(
            bottom: 130,
            right: 40,
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorClass.appGrey2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.list),
                label: const Text(
                  "List of variants",
                  style: AppText.regular,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
