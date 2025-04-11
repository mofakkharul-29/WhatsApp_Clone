import 'package:flutter/material.dart';
import 'package:my_clone/screens/calls_screen.dart';
import 'package:my_clone/screens/chat_screen.dart';
import 'package:my_clone/screens/community_screen.dart';
import 'package:my_clone/screens/update_screen.dart';
import 'package:my_clone/widgets/more_vert.dart';
import 'package:my_clone/widgets/search_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageindex = 0;
  bool isSearching = false;

  void _exitSearchMode() {
    setState(() {
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching
          ? AppBar(
              elevation: 0,
              title: SearchButton(
                page: 'home',
                onBackPressed: _exitSearchMode,
                hintxt: 'Search...',
                sufIcon: Icons.cancel_outlined,
              ),
            )
          : AppBar(
              title: const Text(
                'WhatsApp',
                style: TextStyle(
                  color: Color(0xFF1dab61),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
              ),
              elevation: 1,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/CameraScreen');
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search_outlined),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    debugPrint(value);
                    //for navigating the page while clicking on the desired menu
                    // Navigator.pushNamed(context, value.toString());
                  },
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (BuildContext context) {
                    return MoreVertItems.getMenuItems();
                  },
                ),
              ],
            ),
      bottomNavigationBar: NavigationBar(
        elevation: 1,
        backgroundColor: const Color(0xFFfef7ff),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageindex = index;
          });
        },
        indicatorColor: const Color(0xFFd8fdd2),
        selectedIndex: currentPageindex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.chat),
            icon: Icon(Icons.chat),
            label: 'Chats',
            tooltip: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(Icons.update),
            label: 'Updates',
            tooltip: 'Updates',
          ),
          NavigationDestination(
            icon: Icon(Icons.group),
            label: 'Communities',
            tooltip: 'Communities',
          ),
          NavigationDestination(
            icon: Icon(Icons.call),
            label: 'Calls',
            tooltip: 'Calls',
          ),
        ],
      ),
      body: const <Widget>[
        ChatScreen(),
        // HostingUser(),
        UpdateScreen(),
        CommunityScreen(),
        CallsScreen(),
      ][currentPageindex],
    );
  }
}
