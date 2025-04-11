import 'package:flutter/material.dart';

class FloatPopup {
  static List<PopupMenuEntry<String>> getMenu() {
    return [
      const PopupMenuItem(
        value: '/Invite a friend',
        child: Text('Invite a friend'),
      ),
      const PopupMenuItem(
        value: '/Contacts',
        child: Text('Contacts'),
      ),
      const PopupMenuItem(
        value: '/Refresh',
        child: Text('Refresh'),
      ),
      const PopupMenuItem(
        value: '/Help',
        child: Text('Help'),
      ),
    ];
  }
}
