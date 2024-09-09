import 'package:flutter/material.dart';

class MessagingServiceImpl extends MessagingServiceRepository {
  final messageService = GlobalKey<ScaffoldMessengerState>();

  @override
  void showSnackBar(String message) {
    messageService.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'dana'),
        ),
      ),
    );
  }
}

abstract class MessagingServiceRepository {
  void showSnackBar(String message);
}
