import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate_app/utils/color_class.dart';
import 'package:real_estate_app/utils/svg_icons.dart';
import 'dart:io';

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
    required this.pageIndex,
    required this.onTap,
  }) : super(key: key);

  final int pageIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Platform.isIOS ? 70 : 52,
        right: Platform.isIOS ? 70 : 52,
        bottom: Platform.isIOS ? 36 : 20,
      ),
      height: 70,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: ColorClass.appBlack.withOpacity(0.97),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavBarItem(
            icon: AppAssets.search,
            isSelected: pageIndex == 0,
            index: 0,
            onTap: () => onTap(0),
          ),
          const SizedBox(width: 8),
          _buildNavBarItem(
            icon: AppAssets.messaging,
            isSelected: pageIndex == 1,
            index: 1,
            onTap: () => onTap(1),
          ),
          const SizedBox(width: 8),
          _buildNavBarItem(
            icon: AppAssets.home,
            isSelected: pageIndex == 2,
            index: 2,
            onTap: () => onTap(2),
          ), // Default selected icon
          const SizedBox(width: 8),
          _buildNavBarItem(
            iconData: Icons.favorite,
            isSelected: pageIndex == 3,
            index: 3,
            onTap: () => onTap(3),
          ),
          const SizedBox(width: 8),
          _buildNavBarItem(
            iconData: Icons.person,
            isSelected: pageIndex == 4,
            index: 4,
            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem({
    String? icon,
    IconData? iconData,
    required bool isSelected,
    required int index,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            isSelected ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
        decoration: isSelected
            ? const BoxDecoration(
                color: ColorClass.appOrangeAccent,
                shape: BoxShape.circle,
              )
            : BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
        child: iconData != null
            ? Icon(
                iconData,
                color: ColorClass.appWhite,
              )
            : SvgPicture.asset(
                icon!,
                color: ColorClass.appWhite,
              ),
      ),
    );
  }
}
