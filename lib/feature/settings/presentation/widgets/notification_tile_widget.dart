// --- NEW STATEFUL WIDGET FOR EXPANDABLE TILES ---
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skin_firts/core/theme/color_palette.dart';

class NotificationTile extends StatefulWidget {
  final String iconPath;
  final String title;
  final String body;
  final String time;
  final bool isRead;

  const NotificationTile({
    required this.iconPath,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
  });

  @override
  State<NotificationTile> createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Toggle the expanded state when tapped!
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          color:
              widget.isRead ? Colors.transparent : LightColorPalette.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          // Align items to the top so the icon doesn't sink when expanded
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: LightColorPalette.primary,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                widget.iconPath,
                color: Colors.white,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // 👇 Smoothly animates the size change 👇
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: Text(
                      widget.body,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      // If expanded, maxLines is null (infinite). If not, it's 2.
                      maxLines: _isExpanded ? null : 2,
                      overflow:
                          _isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Push the time down slightly so it aligns nicely with the title
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                widget.time,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
