import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:skin_firts/core/color/light/LIghtColorPalette.dart'; // Import your color palette
import 'package:skin_firts/feature/chats/domain/messages_model.dart';

class AudioMessageBubble extends StatefulWidget {
  final ChatMessage message; // Changed to accept the full message object

  const AudioMessageBubble({
    super.key,
    required this.message,
  });

  @override
  State<AudioMessageBubble> createState() => _AudioMessageBubbleState();
}

class _AudioMessageBubbleState extends State<AudioMessageBubble> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    // Use the URL from the message object
    await _audioPlayer.setUrl(widget.message.content);
    _totalDuration = _audioPlayer.duration ?? Duration.zero;

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (mounted) {
        setState(() {
          _isPlaying = isPlaying;
          if (processingState == ProcessingState.completed) {
            _isPlaying = false;
            _currentPosition = Duration.zero; // Reset to start
            _audioPlayer.seek(Duration.zero); // Rewind
          }
        });
      }
    });

    _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });
  }

  String _formatDuration(Duration d) {
    return d.toString().split('.').first.substring(2, 7); // MM:SS format
  }

  @override
  Widget build(BuildContext context) {
    final isMe = widget.message.sender == MessageSender.me;
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor = isMe ? LightColorPalette.primary : const Color(0xFFE3F2FD);
    final iconColor = isMe ? Colors.white : LightColorPalette.primary;
    final textColor = isMe ? Colors.white : Colors.black;

    // Tweak border radius for the 'sent' message bubble
    final borderRadius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(4.0), // Pointy corner
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
            bottomLeft: Radius.circular(4.0),
            bottomRight: Radius.circular(16.0),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Align(
        alignment: alignment, // Dynamic alignment
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              margin: isMe
                  ? const EdgeInsets.only(left: 80.0) // Margin for sent messages
                  : const EdgeInsets.only(right: 80.0), // Margin for received
              decoration: BoxDecoration(
                color: bubbleColor, // Dynamic color
                borderRadius: borderRadius, // Dynamic border radius
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Keep row compact
                children: [
                  if (!isMe)
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(widget.message.senderAvatar ?? 'assets/icons/default_avatar.png'),
                    ),
                  if (!isMe) const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      if (_isPlaying) {
                        _audioPlayer.pause();
                      } else {
                        _audioPlayer.play();
                      }
                    },
                    child: Icon(
                      _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                      color: iconColor, // Dynamic icon color
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3.0,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 10.0),
                        activeTrackColor: iconColor, // Use icon color for slider
                        inactiveTrackColor: Colors.grey.shade300,
                        thumbColor: iconColor,
                        overlayColor: iconColor.withOpacity(0.2),
                      ),
                      child: Slider(
                        min: 0.0,
                        max: _totalDuration.inMilliseconds.toDouble(),
                        value: _currentPosition.inMilliseconds.toDouble().clamp(0.0, _totalDuration.inMilliseconds.toDouble()),
                        onChanged: (value) {
                          _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDuration(_totalDuration), // Show total duration
                    style: TextStyle(
                      fontSize: 13,
                      color: textColor.withOpacity(0.8), // Dynamic text color
                      fontFamily: "LeagueSpartan",
                    ),
                  ),
                  if (isMe) const SizedBox(width: 8),
                  if (isMe)
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage(widget.message.senderAvatar ?? 'assets/icons/default_avatar.png'),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Text(
                widget.message.time,
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

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
