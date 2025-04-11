import 'package:flutter/material.dart';

class MoreVertItems {
  static List<PopupMenuEntry<String>> getMenuItems() {
    return const [
      PopupMenuItem<String>(
        // value: '/NewGroup',
        value: '/NewGroupPage',
        child: Text('New group'),
      ),
      PopupMenuItem<String>(
        value: '/NewBroadcast',
        child: Text('New broadcast'),
      ),
      PopupMenuItem<String>(
        value: 'LinkedDevices',
        child: Text('Linked devices'),
      ),
      PopupMenuItem<String>(
        value: 'StarredMessages',
        child: Text('Starred messages'),
      ),
      PopupMenuItem<String>(
        value: 'Settings',
        child: Text('Settings'),
      ),
    ];
  }
}
