import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kanooniha/core/Logger.dart';
import 'package:kanooniha/data/serializer/newMessages/messageItem.dart';

class MessengerUIModel {
  final String id, from, title, description, link, date, referenceId;
  final bool read;
  final IconData icon;
  final Color color;

  const MessengerUIModel({
    required this.id,
    required this.from,
    required this.title,
    required this.description,
    required this.read,
    required this.date,
    required this.link,
    required this.referenceId,
    required this.icon,
    required this.color,
  });
}

extension MessngerExtension on NewMessageItem {
  MessengerUIModel getMessengerUiModel() {
    return MessengerUIModel(
        id: id.toString(),
        from: '$oName $oFamily',
        title: title ?? '',
        description: message ?? "",
        date: insertDate ?? '',
        read: hasSeen == true,
        link: filePath ?? '',
        referenceId: messageReference.toString(),
        icon: getIcon(messageKind ?? 1),
        color: messageKind == 2 ? Colors.red : Colors.grey);
  }

  IconData getIcon(num kind) {
    Logger.d('kind is $kind');
    switch (kind) {
      case 0:
        return CupertinoIcons.chat_bubble_text_fill;
      case 1:
        return CupertinoIcons.person_alt;
      case 2:
        return CupertinoIcons.group_solid;
      default:
        return CupertinoIcons.chat_bubble_text_fill;
    }
  }
}
