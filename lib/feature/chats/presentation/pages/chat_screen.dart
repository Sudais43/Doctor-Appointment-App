import 'dart:io'; // Needed for File
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart'; // To get file path
import 'package:permission_handler/permission_handler.dart'; // For permissions
import 'package:record/record.dart'; // The recording package
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart';
import 'package:skin_firts/feature/chats/presentation/widgets/chat_app_bar.dart';

import '../../data/messages.dart';
import '../../domain/messages_model.dart';
import '../widgets/audio_message_bubble.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String doctorName;

  const ChatScreen({super.key, required this.doctorName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // --- Recording State ---
  late final AudioRecorder _audioRecorder;
  bool _isRecording = false;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();
    _toggleTypingIndicator(true);
  }

  // --- 1. RECORDING LOGIC ---

  Future<void> _toggleRecording() async {
    try {
      if (_isRecording) {
        // STOP RECORDING
        final String? filePath = await _audioRecorder.stop();
        setState(() {
          _isRecording = false;
        });

        if (filePath != null) {
          _sendAudioMessage(filePath);
        }
      } else {
        // START RECORDING
        final status = await Permission.microphone.request();
        if (status.isGranted) {
          final directory = await getApplicationDocumentsDirectory();
          // Create a unique file path
          final String filePath =
              '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

          await _audioRecorder.start(const RecordConfig(), path: filePath);

          setState(() {
            _isRecording = true;
          });
          print("Recording started at $filePath");
        } else {
          print("Microphone permission denied");
          // Optionally, you can show a dialog to the user explaining why the
          // permission is needed and how to grant it in the app settings.
        }
      }
    } catch (e) {
      print("Error recording: $e");
    }
  }

  // --- 2. SENDING MESSAGES ---

  void _sendAudioMessage(String path) {
    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: path, // The local file path
      type: MessageType.audio,
      sender: MessageSender.me,
      time: TimeOfDay.now().format(context),
      // For local files, we might need to get duration differently or just show 0:00 initially
      audioDuration: "0:00",
      senderAvatar: "assets/icons/user_avatar.png", // Add a user avatar asset
    );

    setState(() {
      messages.add(newMessage);
      _scrollToBottom();
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: _messageController.text.trim(),
      type: MessageType.text,
      sender: MessageSender.me,
      time: TimeOfDay.now().format(context),
    );

    setState(() {
      messages.add(newMessage);
      _messageController.clear();
      _scrollToBottom();
    });

    _toggleTypingIndicator(true);
    Future.delayed(const Duration(seconds: 3), () {
      _toggleTypingIndicator(false);
      _receiveMessage("Hello! How can I help you today?");
    });
  }

  void _receiveMessage(String text) {
    final receivedMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString() + '_reply',
      content: text,
      type: MessageType.text,
      sender: MessageSender.other,
      time: TimeOfDay.now().format(context),
    );

    setState(() {
      messages.add(receivedMessage);
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toggleTypingIndicator(bool typing) {
    setState(() {
      _isTyping = typing;
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChatAppBar(
        title: widget.doctorName,
        onPressed: () => Navigator.pop(context),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: LightColorPalette.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: LightColorPalette.white),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                if (message.type == MessageType.text) {
                  return ChatBubble(message: message);
                } else if (message.type == MessageType.audio) {
                  return AudioMessageBubble(message: message);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.doctorName} is typing...",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: "LeagueSpartan",
                  ),
                ),
              ),
            ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: LightColorPalette.secondary.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () { print('Attach file'); },
            child: SvgPicture.asset(
              "assets/icons/chat/attachment_icon.svg",
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(LightColorPalette.primary, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                // Change hint text based on recording state
                hintText: _isRecording ? "Recording audio..." : "Write Here...",
                hintStyle: TextStyle(
                  color: _isRecording ? Colors.red : Colors.grey.shade500,
                  fontWeight: _isRecording ? FontWeight.bold : FontWeight.normal,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(color: LightColorPalette.primary, width: 1.0),
                ),
              ),
              style: const TextStyle(fontFamily: "LeagueSpartan"),
              readOnly: _isRecording, // Prevent typing while recording
            ),
          ),
          const SizedBox(width: 10),

          // --- MICROPHONE BUTTON ---
          GestureDetector(
            onTap: _toggleRecording, // Connect to logic
            child: Container(
              // Add a visual indicator (red circle) when recording
              padding: _isRecording ? const EdgeInsets.all(8) : EdgeInsets.zero,
              decoration: _isRecording
                  ? const BoxDecoration(color: Colors.red, shape: BoxShape.circle)
                  : null,
              child: SvgPicture.asset(
                "assets/icons/chat/mic_icon.svg",
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  // Icon becomes white when recording, primary otherwise
                    _isRecording ? Colors.white : LightColorPalette.primary,
                    BlendMode.srcIn
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: SvgPicture.asset(
              "assets/icons/chat/send_icon.svg",
              width: 28,
              height: 28,
              colorFilter: const ColorFilter.mode(LightColorPalette.primary, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
