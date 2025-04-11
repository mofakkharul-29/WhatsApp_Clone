import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_clone/data/logic/cubits/user_cubit.dart';
import 'package:my_clone/data/logic/cubits/user_state.dart';
import 'package:my_clone/data/model/users_model.dart';
import 'package:my_clone/screens/contact_screen.dart';
import 'package:my_clone/widgets/dialogs_show.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<UserModel> _allUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      minimumSize: const Size(40, 30),
                    ),
                    child: Text(
                      'All',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(width: 6),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      minimumSize: const Size(65, 30),
                    ),
                    child: Text(
                      'Unread',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      minimumSize: const Size(80, 30),
                    ),
                    child: Text(
                      'Favourites',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(width: 6),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      minimumSize: const Size(65, 30),
                    ),
                    child: Text(
                      'Groups',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return const CircularProgressIndicator();
                  } else if (state is UserLoadedState) {
                    // final allUsers = state.users;
                    _allUsers = state.users;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _allUsers.length,
                      // itemCount: widget.newUsers.length,
                      itemBuilder: (context, index) {
                        final user = _allUsers[index];
                        // final user = widget.newUsers[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              DialogsShow.showAlignedDialog(
                                  context, user.photo ?? '', user.name ?? '');
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(user.photo ?? ''),
                            ),
                          ),
                          title: InkWell(
                            // mark this well
                            // from here sending the useages to individual page
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/IndividualChatScreen',
                                  arguments: user);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  user.message ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          trailing: Text(user.time ?? ''),
                        );
                      },
                    );
                  } else if (state is UserErrorState) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New chat',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContactScreen(userList: _allUsers)),
            // builder: (context) => ContactScreen(userList: widget.newUsers)),
          );
        },
        backgroundColor: const Color(0xFF1dab61),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add_comment),
      ),
    );
  }
}
