import 'package:flutter/material.dart';

class IndividualPopUp {
  static List<PopupMenuEntry<String>> getMenue(VoidCallback onMoreSelected) {
    return [
      const PopupMenuItem<String>(
        value: '/ViewContact',
        child: Text('View contact'),
      ),
      const PopupMenuItem<String>(
        value: '/Search',
        child: Text('Search'),
      ),
      const PopupMenuItem<String>(
        value: 'AddToList',
        child: Text('Add to list'),
      ),
      const PopupMenuItem<String>(
        value: 'MediaLinksDocs',
        child: Text('Media, links, and docs'),
      ),
      const PopupMenuItem<String>(
        value: 'MuteNotifications',
        child: Text('Mute notifications'),
      ),
      const PopupMenuItem<String>(
        value: 'DisappearingMessages',
        child: Text('Disappearing message'),
      ),
      const PopupMenuItem<String>(
        value: 'Wallpaper',
        child: Text('Wallpaper'),
      ),
      PopupMenuItem<String>(
        value: 'More',
        child: GestureDetector(
          onTap: onMoreSelected,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('More'),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    ];
  }

  static List<PopupMenuEntry<String>> getMenueMore() {
    return const [
      PopupMenuItem(
        value: 'Report',
        child: Text('Report'),
      ),
      PopupMenuItem(
        value: 'Block',
        child: Text('Block'),
      ),
      PopupMenuItem(
        value: 'ClearChat',
        child: Text('Clear chat'),
      ),
      PopupMenuItem(
        value: 'ExportChat',
        child: Text('Export chat'),
      ),
      PopupMenuItem(
        value: 'AddShortcut',
        child: Text('Add shortcut'),
      ),
    ];
  }
}
