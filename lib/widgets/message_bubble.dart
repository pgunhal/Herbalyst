import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class MessageBubble extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MessageBubble({
    required this.content,
    required this.isUserMessage,
    this.showSaveButton = false,
    required this.onSave,
  });

  final String content;
  final bool isUserMessage;
  final bool showSaveButton; // New property to control the visibility of the clipboard icon
  final VoidCallback onSave; // Callback function for when the clipboard icon is pressed

  @override
  Widget build(BuildContext context) {
 Color primaryColor = Color.fromARGB(255, 33, 33, 33);
  Color accentColor = Color.fromRGBO(239, 108, 0, 1);
  final bubbleColor = isUserMessage
      ? primaryColor.withOpacity(0.4) // Use primaryColor instead of colorScheme.primary
      : accentColor.withOpacity(0.8); // Use accentColor instead of colorScheme.secondary
  final textColor = Colors.black;
  
  return Container(
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: bubbleColor,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isUserMessage ? 'You' : 'AI',
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
              if (showSaveButton)
                IconButton(
                  onPressed: onSave,
                  icon: const Icon(Icons.content_copy),
                  iconSize: 16.0,
                  color: textColor,
                ),
            ],
          ),
          // const SizedBox(height: 2),
          MarkdownWidget(
            data: content,
            shrinkWrap: true,
          ),
        ],
      ),
    ),
  );
}
}
