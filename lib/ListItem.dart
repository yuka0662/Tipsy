import 'package:flutter/cupertino.dart';
import 'dart:math';

class ListItem {
  final int id;
  final TextEditingController controller;
  final String text;

  ListItem({
    @required this.id,
    @required this.text,
    @required this.controller,
  });

  factory ListItem.create(String text) {
    return ListItem(
      id: Random().nextInt(99999),
      text: text,
      controller: TextEditingController(text: text),
    );
  }

  ListItem change(String text) {
    return ListItem(id: this.id, text: text, controller: this.controller);
  }

  void dispose() {
    controller.dispose();
  }

  @override
  String toString() {
    return text;
  }
}
