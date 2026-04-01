import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_firts/core/services/api_services.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import 'package:skin_firts/feature/authentication/presentation/widgets/custom_input_field.dart';
import 'package:skin_firts/feature/settings/presentation/widgets/profile_pic.dart';

import '../../../../core/theme/color_palette.dart';
import '../../../../core/widget/CustomButton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isUploadingImage = false;
  String? _networkImageUrl;
  File? _selectedImage;
  final ApiServices apiServices = ApiServices();

  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _isUploadingImage = true;
      });

      // Upload immediately when selected
      final response = await apiServices.uploadProfilePic(_selectedImage!);

      setState(() {
        _isUploadingImage = false;
      });

      if (!mounted) return;

      if (response != null && response.statusCode == 200) {
        final sessionBox = Hive.box('current_session');
        // Save the new image URL to Hive so the Home Page can use it too!
        final newUrl = response.data['profilePic'] ?? (response.data['user'] != null ? response.data['user']['profilePic'] : null);
        
        if (newUrl != null) {
          sessionBox.put('profilePic', newUrl);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Profile picture updated!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to upload image."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _loadUserData() async {
    final response =
        await apiServices
            .getProfile(); // Assuming singleton, adjust if using Provider

    if (response != null && response.statusCode == 200) {
      final data = response.data;
      setState(() {
        nameController.text = data['fullName'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone'] ?? '';
        dobController.text = data['dob'] ?? '';
        _networkImageUrl = data['profilePic'] ?? '';
        _isLoading = false;
      });

      // Sync with Hive so home/profile screens immediately get the DB image
      if (data['profilePic'] != null) {
        Hive.box('current_session').put('profilePic', data['profilePic']);
      }
    } else {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to load profile data"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // 2. SAVE UPDATED DATA
  Future<void> _updateProfile() async {
    setState(() => _isSaving = true);

    final data = {
      "fullName": nameController.text.trim(),
      "email": emailController.text.trim(),
      "phone": phoneController.text.trim(),
      "dob": dobController.text.trim(),
    };

    final response = await apiServices.updateProfile(data);

    setState(() => _isSaving = false);

    if (!mounted) return;

    if (response != null && response.statusCode == 200) {
      // ✅ Update Hive so the Home Page updates instantly!
      final sessionBox = Hive.box('current_session');
      sessionBox.put('userName', nameController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile updated successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context); // Go back to previous screen
    } else {
      final errorMsg = response?.data['error'] ?? "Failed to update profile";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          // Inside your Column children...
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ProfilePic(
                                selectedImage: _selectedImage,
                                networkImageUrl: _networkImageUrl,
                                onTap: _isUploadingImage ? null : _pickAndUploadImage,
                              ),
                              
                              // Show the loading spinner right over the face if uploading
                              if (_isUploadingImage)
                                const CircularProgressIndicator(
                                  color: Colors.blue, // Changed to blue so you can see it
                                ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          // 👇 Much cleaner now!
                          // Stack(
                          //   alignment: Alignment.center,
                          //   children: [
                          //     ProfilePic(
                          //       selectedImage: _selectedImage,
                          //       networkImageUrl: _networkImageUrl,
                          //       onTap: _isUploadingImage ? null : () {
                          //         // 👇 If this prints, your UI is working perfectly!
                          //         debugPrint("📸 Image tapped! Opening gallery...");
                          //         _pickAndUploadImage();
                          //       },
                          //     ),
                          //     if (_isUploadingImage)
                          //       const CircularProgressIndicator(
                          //         color: Colors.white,
                          //       ),
                          //   ],
                          // ),
                          // const SizedBox(height: 30),
                          // Inside _EditProfileState build method...
                          // GestureDetector(
                          //   behavior: HitTestBehavior.opaque,
                          //   onTap:
                          //       _isUploadingImage ? null : _pickAndUploadImage,
                          //   child: Stack(
                          //     alignment: Alignment.center,
                          //     children: [
                          //       // Pass the image variables down to your custom widget
                          //       ProfilePic(
                          //         selectedImage: _selectedImage,
                          //         networkImageUrl: _networkImageUrl,
                          //       ),

                          //       // Show a loading spinner right over the face if uploading
                          //       if (_isUploadingImage)
                          //         const CircularProgressIndicator(
                          //           color: Colors.white,
                          //         ),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(height: 30),
                          SizedBox(height: 30),

                          SizedBox(
                            width: 300,
                            child: Text(
                              "Full Name",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "LeagueSpartan",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          CustomInputField(
                            label: "Muhammad Sudais",
                            controller: nameController,
                          ),

                          SizedBox(height: 15),

                          SizedBox(
                            width: 300,
                            child: Text(
                              "Date Of Birth",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "LeagueSpartan",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          CustomInputField(
                            label: "5/6/2002",
                            controller: dobController,
                          ),

                          SizedBox(height: 15),

                          SizedBox(
                            width: 300,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "LeagueSpartan",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          CustomInputField(
                            label: "abc@gmail.com",
                            controller: emailController,
                          ),

                          SizedBox(height: 15),

                          SizedBox(
                            width: 300,
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "LeagueSpartan",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          CustomInputField(
                            label: "12345",
                            controller: phoneController,
                          ),

                          SizedBox(height: 60),

                          CustomButton(
                            width: 160,
                            height: 36,
                            BackgroundColor: LightColorPalette.primary,
                            text: _isSaving ? "Saving..." : "Update Profile",
                            onPressed: _isSaving ? () {} : _updateProfile,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
