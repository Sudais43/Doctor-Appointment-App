// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class ProfilePic extends StatelessWidget {
//   final File? selectedImage;
//   final String? networkImageUrl;

//   const ProfilePic({
//     super.key,
//     this.selectedImage,
//     this.networkImageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // 1. Determine which image provider to use
//     ImageProvider imageProvider;
//     if (selectedImage != null) {
//       imageProvider = FileImage(selectedImage!); // Show newly picked image
//     } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
//       // Show network image (replace 10.0.2.2 with your server IP if needed)
//       imageProvider = NetworkImage("http://10.0.2.2:3000$networkImageUrl");
//     } else {
//       // Default fallback
//       imageProvider = const AssetImage("assets/icons/Doctors/images/doctor1.png");
//     }

//     return SafeArea(
//       child: Stack(
//         children: [
//           SizedBox(
//             height: 127,
//             width: 127,
//             child: CircleAvatar(
//               backgroundImage: imageProvider,
//             ),
//           ),
//           Positioned(
//             left: 95,
//             top: 95,
//             child: SvgPicture.asset("assets/icons/settings/edit_icon.svg"),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class ProfilePic extends StatelessWidget {
//   final File? selectedImage;
//   final String? networkImageUrl;
//   final VoidCallback? onTap; // 👈 ADD THIS

//   const ProfilePic({
//     super.key,
//     this.selectedImage,
//     this.networkImageUrl,
//     this.onTap, // 👈 ADD THIS
//   });

//   @override
//   Widget build(BuildContext context) {
//     ImageProvider imageProvider;
//     if (selectedImage != null) {
//       imageProvider = FileImage(selectedImage!); 
//     } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
//       imageProvider = NetworkImage("http://10.0.2.2:3000$networkImageUrl");
//     } else {
//       imageProvider = const AssetImage("assets/icons/Doctors/images/doctor1.png");
//     }

//     // 👇 Wrap everything in GestureDetector and remove SafeArea
//     return GestureDetector(
//       onTap: onTap,
//       child: SizedBox(
//         height: 127,
//         width: 127,
//         child: Stack(
//           children: [
//             CircleAvatar(
//               radius: 63.5, // Half of 127
//               backgroundImage: imageProvider,
//             ),
//             Positioned(
//               left: 95,
//               top: 95,
//               child: SvgPicture.asset("assets/icons/settings/edit_icon.svg"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePic extends StatelessWidget {
  final File? selectedImage;
  final String? networkImageUrl;
  final VoidCallback? onTap; // The function to run when tapped

  const ProfilePic({
    super.key,
    this.selectedImage,
    this.networkImageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine which image to show
    ImageProvider imageProvider;
    if (selectedImage != null) {
      imageProvider = FileImage(selectedImage!);
    } else if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
      imageProvider = NetworkImage("http://10.0.2.2:3000$networkImageUrl");
    } else {
      imageProvider = const AssetImage("assets/icons/Doctors/images/doctor1.png");
    }

    return SizedBox(
      height: 127,
      width: 127,
      child: Stack(
        clipBehavior: Clip.none, // Prevents clipping if the icon overlaps
        children: [
          // 1. The Main Image (Clickable)
          CircleAvatar(
            radius: 63.5,
            backgroundImage: imageProvider,
            backgroundColor: Colors.grey[200],
          ),

          // 2. The Edit Icon (Clickable)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // White background creates a solid tap area
              ),
              child: Center(
                child: SvgPicture.asset("assets/icons/settings/edit_icon.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}