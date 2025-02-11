import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/color_class.dart';

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
      margin: const EdgeInsets.only(
        left: 70,
        right: 70,
        bottom: 36,
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
            Icons.search,
            pageIndex == 0,
            0,
            onTap: () => onTap(0),
          ),
          const SizedBox(width: 8),
          _buildNavBarItem(
            Icons.message,
            pageIndex == 1,
            1,
            onTap: () => onTap(1),
          ),
          const SizedBox(width: 8),
          _buildNavBarItem(
            Icons.home_filled,
            pageIndex == 2,
            2,
            onTap: () => onTap(2),
          ), // Default selected icon
          const SizedBox(width: 8),
          _buildNavBarItem(
            Icons.favorite,
            pageIndex == 3,
            3,
            onTap: () => onTap(3),
          ),
          const SizedBox(width: 8),
          _buildNavBarItem(
            Icons.person,
            pageIndex == 4,
            4,
            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(IconData icon, bool isSelected, int index,
      {Function()? onTap}) {
    // final bool isSelected = pageIndex == index;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            isSelected ? const EdgeInsets.all(18) : const EdgeInsets.all(10),
        decoration: isSelected
            ? const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              )
            : BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white,
        ),
      ),
    );
  }
}
