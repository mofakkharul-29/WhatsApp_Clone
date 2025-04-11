import 'package:flutter/material.dart';
import 'package:my_clone/data/model/users_model.dart';
import 'package:my_clone/screens/popUp/float_popup.dart';
import 'package:my_clone/widgets/contact_card.dart';
import 'package:my_clone/widgets/new_group_page.dart';
import 'package:my_clone/widgets/search_button.dart';

class ContactScreen extends StatefulWidget {
  final List<UserModel> userList;
  const ContactScreen({super.key, required this.userList});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool isSearching = false;
  List<UserModel> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = widget.userList;
  }

  void _filterContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUsers = widget.userList;
      } else {
        filteredUsers = widget.userList
            .where((user) =>
                user.name != null &&
                user.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching
          ? AppBar(
              automaticallyImplyLeading: false,
              elevation: 1,
              title: SearchButton(
                page: 'contact',
                onBackPressed: () {
                  setState(() {
                    isSearching = false;
                    filteredUsers = widget.userList;
                  });
                },
                hintxt: 'Search name or number...',
                sufIcon: Icons.dialpad,
                onSearchChanged: _filterContacts,
              ),
            )
          : AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              automaticallyImplyLeading: false,
              titleSpacing: -2,
              title: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select contact',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.userList.length} contacts',
                        style:
                            const TextStyle(fontSize: 11, letterSpacing: 0.5),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
                PopupMenuButton(
                  constraints: const BoxConstraints(
                    minWidth: 180,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  itemBuilder: (BuildContext context) {
                    return FloatPopup.getMenu();
                  },
                  child: const Icon(Icons.more_vert),
                ),
              ],
            ),
      body: isSearching
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Contacts on WhatsApp'),
                  // add user card
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        return ContactCard(user: filteredUsers[index]);
                      },
                    ),
                  ),
                ],
              ),
            )
          : CustomScrollView(
              slivers: [
                // Header Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      children: [
                        _buildHeaderOption(
                          Icons.group_add,
                          "New group",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => NewGroupPage(
                                        userList: widget.userList)));
                          },
                        ),
                        _buildHeaderOption(
                          Icons.person_add_alt_1_rounded,
                          "New contact",
                          trailingIcon: Icons.qr_code,
                          onTap: () {
                            // print('New contact tapped');
                          },
                          onTraillingTap: () {
                            // print('qr code tapped');
                          },
                        ),
                        _buildHeaderOption(
                          Icons.groups,
                          "New community",
                          onTap: () {
                            // print('New Community tapped');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // Divider with label
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Contacts on WhatsApp',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                // Contact List

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final user = widget.userList[index];
                      return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/IndividualChatScreen',
                                arguments: user);
                          },
                          child: ContactCard(user: user));

                      ///
                    },
                    childCount: widget.userList.length,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildHeaderOption(IconData icon, String title,
      {IconData? trailingIcon,
      VoidCallback? onTraillingTap,
      VoidCallback? onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xff1dab61),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: trailingIcon != null
          ? IconButton(
              onPressed: onTraillingTap,
              icon: Icon(trailingIcon, size: 18),
            )
          : null,
      onTap: onTap,
    );
  }
}
