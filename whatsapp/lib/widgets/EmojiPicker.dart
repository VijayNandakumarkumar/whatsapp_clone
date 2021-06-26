import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';

Widget emojiPicker(final TextEditingController textEditingController) {
  return EmojiPicker(
      rows: 4,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        textEditingController.text = textEditingController.text + emoji.emoji;
      });
}