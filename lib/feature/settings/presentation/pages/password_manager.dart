import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:skin_firts/core/theme/color_palette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart';
import '../../../../core/widget/CustomButton.dart';
import '../../../authentication/presentation/widgets/custom_input_field.dart';

class PasswordManager extends StatefulWidget {
  const PasswordManager({super.key});

  @override
  State<PasswordManager> createState() => _PasswordManagerState();
}

class _PasswordManagerState extends State<PasswordManager> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    final currentPass = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (currentPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (newPass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New passwords do not match."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // To update the API, uncomment and use your AuthViewModel here.
      // Ensure you have a changePassword method implemented in AuthViewModel.
      /*
      final authVM = context.read<AuthViewModel>();
      final success = await authVM.changePassword(currentPass, newPass);
      */

      // Simulating API call for demonstration:
      await Future.delayed(const Duration(seconds: 2));
      bool success = true; // Replace with actual API response status

        // Store the new password in local storage (Hive)
        final authBox = Hive.box('auth_box');
        await authBox.put('password', newPass); // Save to local storage

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Password updated successfully!"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context); // Go back after successful update
        }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Password Manager",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: LightColorPalette.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        SizedBox(
                          width: 300,
                          child: Text(
                            "Current Password",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        CustomInputField(
                          label: "**********",
                          controller: currentPasswordController,
                          obscureText: _obscureCurrent,
                          suffixIcon: GestureDetector(
                            onTap:
                                () => setState(
                                  () => _obscureCurrent = !_obscureCurrent,
                                ),
                            child: SvgPicture.asset(
                              "assets/icons/Authentication/show_pass_icon.svg",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 300,
                          child: Text(
                            "Forgot Password?",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15,
                              color: LightColorPalette.primary,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        SizedBox(
                          width: 300,
                          child: Text(
                            "New Password",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        CustomInputField(
                          obscureText: _obscureNew,
                          label: "**********",
                          controller: newPasswordController,
                          suffixIcon: GestureDetector(
                            onTap:
                                () =>
                                    setState(() => _obscureNew = !_obscureNew),
                            child: SvgPicture.asset(
                              "assets/icons/Authentication/show_pass_icon.svg",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        SizedBox(
                          width: 300,
                          child: Text(
                            "Confirm Password",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 7),
                        CustomInputField(
                          obscureText: _obscureConfirm,
                          label: "**********",
                          controller: confirmPasswordController,
                          suffixIcon: GestureDetector(
                            onTap:
                                () => setState(
                                  () => _obscureConfirm = !_obscureConfirm,
                                ),
                            child: SvgPicture.asset(
                              "assets/icons/Authentication/show_pass_icon.svg",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),

                        SizedBox(height: 40),

                        _isLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                              text: "Update Password",
                              BackgroundColor: LightColorPalette.primary,
                              onPressed: _updatePassword,
                            ),
                      ],
                    ),
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
