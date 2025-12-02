enum MessageType { text, audio }
enum MessageSender { me, other } // 'me' is the sender, 'other' is the receiver (Dr. Olivia)

class ChatMessage {
  final String id;
  final String content; // Text message or audio file path/URL
  final MessageType type;
  final MessageSender sender;
  final String time; // e.g., "09:00"
  final String? audioDuration; // "02:50" for audio messages
  final String? senderAvatar; // Only for 'other' sender audio, for display

  ChatMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.sender,
    required this.time,
    this.audioDuration,
    this.senderAvatar,
  });
}