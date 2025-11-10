import 'package:flutter/material.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/core/widget/custom_app_bar.dart'; // Assuming this is your custom app bar

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your common text styles
    final TextStyle _bodyTextStyle = TextStyle(
      fontSize: 14,
      height: 1.0, // Line height for readability
      color: Colors.black87,
      fontFamily: "LeagueSpartan",
      fontWeight: FontWeight.w200,
    );

    final TextStyle _headingTextStyle = TextStyle(
      fontSize: 20,
      color: LightColorPalette.primary, // Blue heading color
      fontFamily: "LeagueSpartan",
      fontWeight: FontWeight.w500,
    );

    final TextStyle _lastUpdateTextStyle = TextStyle(
      fontSize: 12,
      color: LightColorPalette.textColor, // Blue for last update
      fontFamily: "LeagueSpartan",
      fontWeight: FontWeight.w400,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Privacy Policy", // Title from your image
        onPressed: () {
          Navigator.pop(context); // Standard back button action
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
            children: [
              // --- Last Update Date ---
              Text(
                "Last Update: 14/08/2024",
                style: _lastUpdateTextStyle,
              ),
              const SizedBox(height: 15),

              // --- Privacy Policy Content ---
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam. Fusce a scelerisque neque, sed accumsan metus. "
                    "Nunc auctor tortor in dolor luctus, quis euismod urna tincidunt. Aenean arcu metus, bibendum at rhoncus at, volutpat ut lacus. Morbis pellentesque malesuada eros semper ultrices. Vestibulum lobortis enim vel neque auctor, a ultrices ex placerat. "
                    "Mauris ut lacinia justo, sed suscipit tortor. Nam egestas nulla posuere neque tincidunt porto.",
                style: _bodyTextStyle,
              ),
              const SizedBox(height: 25),

              Text(
                "Nunc auctor tortor in dolor luctus, quis euismod urna tincidunt. Aenean arcu metus, bibendum at rhoncus at, volutpat ut lacus. Morbis pellentesque malesuada eros semper ultrices. Vestibulum lobortis enim vel neque auctor, a ultrices ex placerat. "
                    "Mauris ut lacinia justo, sed suscipit tortor. Nam egestas nulla posuere neque tincidunt porto.",
                style: _bodyTextStyle,
              ),
              const SizedBox(height: 35), // More space before the next section

              // --- Terms & Conditions Heading ---
              Text(
                "Terms & Conditions",
                style: _headingTextStyle,
              ),
              const SizedBox(height: 20),

              // --- Terms & Conditions List Items ---
              _buildNumberedListItem(
                number: "1.",
                text: "Ut lacinia justo sit amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra eros est vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare accumsan. Duis laoreet, ex eget rutrum pharetra, lectus nisl posuere risus, vel facilisis nisi tellus ac turpis.",
                bodyStyle: _bodyTextStyle,
              ),
              const SizedBox(height: 15),

              _buildNumberedListItem(
                number: "2.",
                text: "Ut lacinia justo sit amet lorem sodales accumsan. Proin malesuada eleifend fermentum. Donec condimentum, nunc at rhoncus faucibus, ex nisi laoreet ipsum, eu pharetra eros est vitae orci. Morbi quis rhoncus mi. Nullam lacinia ornare accumsan. Duis laoreet, ex eget rutrum pharetra, lectus nisl posuere risus, vel facilisis nisi tellus.",
                bodyStyle: _bodyTextStyle,
              ),
              const SizedBox(height: 15),

              _buildNumberedListItem(
                number: "3.",
                text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam.",
                bodyStyle: _bodyTextStyle,
              ),
              const SizedBox(height: 15),

              _buildNumberedListItem(
                number: "4.",
                text: "Nunc auctor tortor in dolor luctus, quis euismod urna tincidunt. Aenean arcu metus, bibendum at rhoncus at, volutpat ut lacus. Morbis pellentesque malesuada eros semper ultrices. Vestibulum lobortis enim vel neque auctor, a ultrices ex placerat. Mauris ut lacinia justo, sed suscipit tortor. Nam egestas nulla posuere neque tincidunt porto.",
                bodyStyle: _bodyTextStyle,
              ),
              const SizedBox(height: 20), // Padding at the bottom
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widget for Numbered List Items ---
  Widget _buildNumberedListItem({
    required String number,
    required String text,
    required TextStyle bodyStyle,
  }) {
    // We use a Row to put the number and the text side-by-side
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the top
      children: [
        SizedBox(
          width: 25, // Give fixed width for the number to keep it aligned
          child: Text(
            number,
            style: bodyStyle.copyWith(fontWeight: FontWeight.bold), // Bold number
          ),
        ),
        Expanded(
          // Text takes up the rest of the available width
          child: Text(
            text,
            style: bodyStyle,
          ),
        ),
      ],
    );
  }
}