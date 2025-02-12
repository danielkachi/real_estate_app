import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate_app/utils/app_text.dart';
import 'package:real_estate_app/utils/color_class.dart';
import 'package:real_estate_app/utils/svg_icons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.tab});

  final int tab;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool showPriceMarkers = false;
  bool animateMarkers = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        animateMarkers = true;
      });
    });
  }

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
                      _buildMarker(59.9732, 30.3251,
                          showPriceMarkers ? "6,95 mn ₽" : null),
                      _buildMarker(59.9323, 30.3221,
                          showPriceMarkers ? "6,95 mn ₽" : null),
                      _buildMarker(59.9301, 30.3876,
                          showPriceMarkers ? "6,95 mn ₽" : null),
                      _buildMarker(59.9593, 30.4051,
                          showPriceMarkers ? "6,95 mn ₽" : null),
                      _buildMarker(59.9093, 30.3301,
                          showPriceMarkers ? "6,95 mn ₽" : null),
                      _buildMarker(59.9003, 30.3981,
                          showPriceMarkers ? "6,95 mn ₽" : null),
                    ],
                  ),
                ],
              ),
              _buildSearchBar(),
              _buildFloatingButtons(context),
              _buildVariantList(),
            ],
          ),
        );
      },
    );
  }

  Marker _buildMarker(double lat, double lng, String? price) {
    return Marker(
      point: LatLng(lat, lng),
      width: price != null ? price.length * 12.w : 50.w,
      height: price != null ? 44.h : 50.h,
      child: AnimatedSlide(
        offset: animateMarkers ? Offset.zero : const Offset(-1, 0),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: ColorClass.appOrange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
              bottomLeft: const Radius.circular(0),
            ),
          ),
          child: price != null
              ? Text(
                  price,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : SvgPicture.asset(
                  AppAssets.building,
                  color: ColorClass.appWhite,
                ),
        ),
      ),
    );
  }

  void _showNearMeDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            Positioned(
              left: 20.w,
              bottom: 140.h,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.8, // Ensure bounded width
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
                              isSelected: true, showPrice: true),
                          _buildDialogOption(Icons.apartment, "Infrastructure"),
                          _buildDialogOption(
                              Icons.layers_clear, "Without any layer"),
                        ],
                      ),
                    ),
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
      {bool isSelected = false, bool showPrice = false}) {
    return ListTile(
      leading: Icon(icon,
          color: isSelected ? ColorClass.appOrangeAccent : ColorClass.appGrey),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: isSelected ? ColorClass.appOrangeAccent : ColorClass.appGrey,
        ),
      ),
      onTap: () {
        if (showPrice) {
          setState(() {
            showPriceMarkers = true;
          });
        }
        Navigator.of(context).pop();
      },
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
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      AppAssets.searchOutlined,
                    ),
                  ),
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
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                AppAssets.filter,
                color: ColorClass.appGrey2,
              ),
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
          SizedBox(
            width: 48.w, // Increase width
            height: 48.h, // Increase height
            child: FloatingActionButton(
              heroTag: "layers",
              backgroundColor: ColorClass.appGrey2,
              child: SvgPicture.asset(
                AppAssets.layer,
                color: ColorClass.appCream,
                width: 20.w,
                height: 20.h,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: 48.w,
            height: 48.h,
            child: FloatingActionButton(
              heroTag: "location",
              backgroundColor: ColorClass.appGrey2,
              child: SvgPicture.asset(
                AppAssets.location,
                color: ColorClass.appCream,
                width: 20.w,
                height: 20.h,
              ),
              onPressed: () {
                _showNearMeDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantList() {
    return Positioned(
      bottom: 130,
      right: 40,
      child: SizedBox(
        height: 50,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorClass.appGrey2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
          onPressed: () {},
          icon: SvgPicture.asset(AppAssets.menu, color: ColorClass.appCream),
          label: const Text("List of variants", style: AppText.regularCream),
        ),
      ),
    );
  }
}
