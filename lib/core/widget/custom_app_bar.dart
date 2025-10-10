import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final VoidCallback? onSearch;
  final VoidCallback? onSort;

  final String title;
  final bool showSearch;
  final bool showSort;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onPressed,
    this.showBackButton = true,
    this.showSearch = false,
    this.showSort = false,
    this.onSearch,
    this.onSort,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showBackButton)
            GestureDetector(
              onTap: onPressed,
                child: BackButton(color: LightColorPalette.primary)
            )
          else
            SizedBox(width: 48),

          // SizedBox(width: 120),
          Text(
            title,
            style: TextStyle(
              fontSize: 27,
              fontFamily: "LeagueSpartan",
              fontWeight: FontWeight.w700,
              color: LightColorPalette.primary,
            ),
          ),

          if (showSearch || showSort)
            Row(
              children: [
                if (showSearch)
                  GestureDetector(
                    onTap: onSearch,
                    child: SizedBox(
                      height: 21,
                      width: 21,
                      child: CircleAvatar(
                        backgroundColor: LightColorPalette.white,
                        child: SvgPicture.asset(
                          "assets/icons/Doctors/search_icon.svg",
                        ),
                      ),
                    ),
                  ),
                if (showSort)
                  GestureDetector(
                    onTap: onSort,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: SizedBox(
                        height: 21,
                        width: 21,
                        child: CircleAvatar(
                          backgroundColor: LightColorPalette.white,
                          child: SvgPicture.asset(
                            "assets/icons/Doctors/sorting_icon.svg", color: LightColorPalette.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(width: 30),
              ],
            ),
          // SizedBox(width: 30),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 60);
}
