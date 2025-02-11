import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate_app/utils/app_text.dart';
import 'package:real_estate_app/utils/color_class.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.tab});

  final int tab;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(59.9311, 30.3609),
                  initialZoom: 12.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png",
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      _buildMarker(59.9343, 30.3351),
                      _buildMarker(59.9273, 30.3221),
                      _buildMarker(59.9201, 30.3551),
                      _buildMarker(59.9403, 30.3811),
                    ],
                  ),
                ],
              ),
              _buildSearchBar(),
              _buildFloatingButtons(context),
              _buildRadiantList(),
            ],
          ),
        );
      },
    );
  }

  Marker _buildMarker(double lat, double lng) {
    return Marker(
      point: LatLng(lat, lng),
      width: 40.w,
      height: 40.h,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(Icons.apartment, color: Colors.white, size: 24.sp),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Positioned(
      top: 70.h,
      left: 20.w,
      right: 20.w,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon:
                      const Icon(Icons.search, color: ColorClass.appBlack),
                  hintText: "Saint Petersburg",
                  hintStyle: AppText.regularBlack,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            const CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: Icon(Icons.tune, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingButtons(BuildContext context) {
    return Positioned(
      left: 40.w,
      bottom: 110.h,
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: "layers",
            mini: true,
            backgroundColor: ColorClass.appGrey2,
            child: const Icon(Icons.layers, color: Colors.white),
            onPressed: () {},
          ),
          SizedBox(height: 10.h),
          FloatingActionButton(
            heroTag: "location",
            mini: true,
            backgroundColor: ColorClass.appGrey2,
            child: const Icon(Icons.near_me, color: Colors.white),
            onPressed: () {
              _showNearMeDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showNearMeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              bottom: 120.h,
              left: 10.w,
              right: 20.w,
              child: Material(
                color: Colors.transparent,
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  backgroundColor: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDialogOption(
                          Icons.check_circle_outline, "Cosy areas"),
                      _buildDialogOption(Icons.wallet, "Price",
                          isSelected: true),
                      _buildDialogOption(Icons.apartment, "Infrastructure"),
                      _buildDialogOption(
                          Icons.layers_clear, "Without any layer"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogOption(IconData icon, String text,
      {bool isSelected = false}) {
    return ListTile(
      leading: Icon(icon,
          color: isSelected ? ColorClass.appOrangeAccent : ColorClass.appGrey),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: 'EuclidCircularA',
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: isSelected ? ColorClass.appOrangeAccent : ColorClass.appGrey,
        ),
      ),
      onTap: () {},
    );
  }

  Widget _buildRadiantList() {
    return Positioned(
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
    );
  }
}
