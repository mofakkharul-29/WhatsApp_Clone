import 'package:flutter/material.dart';
import 'package:my_clone/data/model/users_model.dart';
import 'package:my_clone/widgets/contact_card.dart';
import 'package:my_clone/widgets/search_button.dart';

class NewGroupPage extends StatefulWidget {
  final List<UserModel> userList;
  const NewGroupPage({super.key, required this.userList});

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  bool isSearching = false;
  List<UserModel> filteredUsers = [];
  List<UserModel> groups = [];

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
                        'New group',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      groups.isNotEmpty
                          ? Text(
                              '${groups.length} of ${widget.userList.length} selected',
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.black),
                            )
                          : const Text(
                              'Add members',
                              style:
                                  TextStyle(fontSize: 11, letterSpacing: 0.5),
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
              ],
            ),
      body: Stack(
        children: [
          isSearching
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 18.0),
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
                            return InkWell(
                                onTap: () {
                                  final getuser = filteredUsers[index];
                                  setState(() {
                                    if (!groups.contains(getuser)) {
                                      getuser.isChecked = true;
                                      groups.add(getuser);
                                    }
                                  });
                                },
                                child: ContactCard(user: filteredUsers[index]));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                    top: groups.isNotEmpty ? 80.0 : 0.0,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                if (user.isChecked == false) {
                                  setState(() {
                                    user.isChecked = true;
                                    groups.add(user);
                                  });
                                } else {
                                  setState(() {
                                    user.isChecked = false;
                                    groups.remove(user);
                                  });
                                }
                              },
                              child: ContactCard(
                                user: user,
                              ),
                            );
                          },
                          childCount: widget.userList.length,
                        ),
                      ),
                    ],
                  ),
                ),
          groups.isNotEmpty
              ? Container(
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 247, 245, 245),
                    border: Border(
                      top: BorderSide(
                        style: BorderStyle.solid,
                        width: 0.18,
                        color: Color.fromARGB(255, 187, 183, 183),
                      ),
                      bottom: BorderSide(
                        style: BorderStyle.solid,
                        width: 0.2,
                        color: Color.fromARGB(255, 187, 183, 183),
                      ),
                    ),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  UserModel currentUser = groups[index];
                                  currentUser.isChecked = false;
                                  groups.remove(currentUser);
                                });
                              },
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    child: Image.network(
                                        groups[index].photo ?? ''),
                                  ),
                                  const Positioned(
                                    left: 26,
                                    // right: 1,
                                    bottom: 1,
                                    child: CircleAvatar(
                                      radius: 9,
                                      backgroundColor: Colors.grey,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                groups[index].name ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
