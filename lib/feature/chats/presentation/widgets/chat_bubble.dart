import 'package:flutter/material.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart'; // Import your color palette
import '../../domain/messages_model.dart'; // Import the message model

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Define bubble colors based on sender
    final Color bubbleColor = message.sender == MessageSender.me
        ? LightColorPalette.primary.withOpacity(0.8) // Darker blue for 'me'
        : const Color(0xFFE3F2FD); // Light blue for 'other' (Dr. Olivia)

    final Color textColor = message.sender == MessageSender.me
        ? Colors.white
        : LightColorPalette.textColor ?? Colors.black87;

    // Align bubble to right for 'me', left for 'other'
    final AlignmentGeometry alignment = message.sender == MessageSender.me
        ? Alignment.centerRight
        : Alignment.centerLeft;

    // Padding for the bubble
    final EdgeInsetsGeometry bubblePadding = message.sender == MessageSender.me
        ? const EdgeInsets.only(left: 80.0) // More padding on left for 'me'
        : const EdgeInsets.only(right: 80.0); // More padding on right for 'other'

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Align(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: message.sender == MessageSender.me
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              margin: bubblePadding,
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0),
                  bottomLeft: Radius.circular(
                      message.sender == MessageSender.me ? 16.0 : 4.0),
                  bottomRight: Radius.circular(
                      message.sender == MessageSender.me ? 4.0 : 16.0),
                ),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontFamily: "LeagueSpartan", // Ensure consistent font
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: message.sender == MessageSender.me
                  ? const EdgeInsets.only(right: 12.0)
                  : const EdgeInsets.only(left: 12.0),
              child: Text(
                message.time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontFamily: "LeagueSpartan",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}