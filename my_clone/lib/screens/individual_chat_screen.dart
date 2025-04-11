import 'dart:async';
import 'dart:convert';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:my_clone/data/model/users_model.dart';
import 'package:my_clone/screens/popUp/Individual_pop_up.dart';
import 'package:my_clone/widgets/bottom_sheet.dart';
import 'package:my_clone/widgets/own_message_card.dart';
import 'package:my_clone/widgets/reply_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualChatScreen extends StatefulWidget {
  const IndividualChatScreen({super.key});

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  // late IO.Socket socket;
  final GlobalKey _menuKey = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool show = false;
  String? userId;
  List<Map<String, String>> conversation = [];
  String? senderId;
  String? userPersonalId;

  void _showMenuMore() {
    Navigator.of(context).pop();
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: IndividualPopUp.getMenueMore(),
    );
  }

  @override
  void initState() {
    super.initState();
    // connectServer();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    _controller.addListener(() async {
      setState(() {});

      if (userId != null) {
        await _saveDraft(userId!);
      }
    });
  }

  // void connectServer() {
  //   socket = IO.io(
  //     'http://192.168.0.118:5000',
  //     IO.OptionBuilder()
  //         .setTransports(['websocket'])
  //         .disableAutoConnect()
  //         .build(),
  //   );

  //   socket.connect();
  //   socket.onConnect((_) {
  //     debugPrint('Connected to server my socket id: ${socket.id}');
  //     senderId = socket.id;
  //     debugPrint('sender id is set to: $senderId');
  //     _saveSocketIdLocally(senderId!);
  //     if (userId != null) {
  //       setState(() {
  //         userPersonalId = userId;
  //       });
  //       socket.emit(
  //           'register_user', {'senderId': senderId, 'userId': userPersonalId});
  //       debugPrint('User registered on server with ID: $senderId');
  //       debugPrint('My Personal User Id after connect is: $userId');
  //     }
  //   });

  //   socket.onDisconnect((_) {
  //     debugPrint('Disconnected from server');
  //   });

  //   socket.on('receive_message', (data) {
  //     setState(() {
  //       conversation.add({'text': data['message'], 'sender': 'server'});
  //     });
  //     debugPrint('Message from server: ${data['message']}');
  //   });
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final singleUser = ModalRoute.of(context)?.settings.arguments as UserModel?;
    if (singleUser != null) {
      userId = singleUser.id;
      _loadDraft(userId!);
      _loadConversation(userId!);
    }
  }

  Future<void> _saveSocketIdLocally(String socketId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('socketId', socketId);
  }

  Future<void> _saveDraft(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('draft_message_$userId', _controller.text);
  }

  Future<void> _saveConversation(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> serializedConversation = conversation
        .map((singleConversation) => jsonEncode(singleConversation))
        .toList();
    await prefs.setStringList('conversation_$userId', serializedConversation);
    // await prefs.setStringList('conversation_$userId', conversation);
  }

  Future<void> _loadConversation(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final savedConversation = prefs.getStringList('conversation_$userId') ?? [];
    setState(() {
      conversation = savedConversation
          .map((string) => Map<String, String>.from(jsonDecode(string)))
          .toList();
    });
  }

  Future<void> _loadDraft(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final draft = prefs.getString('draft_message_$userId') ?? '';
    _controller.text = draft;
  }

  Future<void> _clearDraft(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('draft_message_$userId');
  }

  // late List<String> conversation = [];

  @override
  Widget build(BuildContext context) {
    final singleUser = ModalRoute.of(context)?.settings.arguments as UserModel?;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const Icon(Icons.arrow_back),
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(singleUser?.photo ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        title: GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                singleUser?.name ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'last seen today at 7:27 AM',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined),
          ),
          PopupMenuButton(
            key: _menuKey,
            onSelected: (value) {
              if (value == 'More') {
                _showMenuMore();
              }
            },
            itemBuilder: (BuildContext context) {
              return IndividualPopUp.getMenue(_showMenuMore);
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
        centerTitle: false,
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, dynamic) async {
          if (didPop) {
            return;
          } else if (show) {
            setState(() {
              show = false;
            });
          } else {
            // final currentSingleUser =
            //     ModalRoute.of(context)?.settings.arguments as UserModel?;
            final currentSingleUser = singleUser;
            // final singleUser =
            // ModalRoute.of(context)?.settings.arguments as UserModel?;

            if (currentSingleUser != null) {
              await _saveDraft(currentSingleUser.id.toString());
            }
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: [
            // Background image layer
            Positioned.fill(
              child: Image.network(
                'https://i.pinimg.com/736x/0b/f2/80/0bf280388937448d38392b76c15bd441.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Foreground content layer
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: conversation.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final message = conversation[index];
                      debugPrint('i am checking: $message');
                      if (message['sender'] == 'self') {
                        return OwnMessageCard(msg: message['text']!);
                      } else if (message['sender'] == 'server') {
                        return ReplyMessage(text: message);
                      }
                      return Container();
                    },
                  ), // Placeholder for chat messages
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextField(
                              controller: _controller,
                              focusNode: _focusNode,
                              maxLines: 5,
                              minLines: 1,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (show) {
                                        // Hide emoji picker and show keyboard
                                        show = false;
                                        _focusNode
                                            .requestFocus(); // Focus on the TextField
                                      } else {
                                        // Show emoji picker and hide keyboard
                                        show = true;
                                        _focusNode
                                            .unfocus(); // Remove focus from TextField
                                      }
                                    });
                                  },
                                  icon: !show
                                      ? const Icon(
                                          Icons.emoji_emotions_outlined)
                                      : const Icon(Icons.keyboard_alt_outlined),
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (BuildContext context) {
                                            final sheet = MyBottomSheet();
                                            return sheet.bottomSheet(context);
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.attach_file_outlined),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/CameraScreen');
                                      },
                                      icon:
                                          const Icon(Icons.camera_alt_outlined),
                                    ),
                                  ],
                                ),
                                hintText: 'Message',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        CircleAvatar(
                          backgroundColor: const Color(0xFF1dab61),
                          radius: 23.0,
                          child: IconButton(
                            onPressed: () async {
                              if (_controller.text.isNotEmpty) {
                                final singleUser = ModalRoute.of(context)
                                    ?.settings
                                    .arguments as UserModel?;
                                final message = _controller.text;

                                if (singleUser != null) {
                                  final receiverId = singleUser.id;
                                  setState(() {
                                    conversation.add(
                                        {'text': message, 'sender': 'self'});
                                  });
                                  debugPrint(
                                      'Sending message from senderId: $senderId to receiverId: $receiverId');

                                  // socket.emitWithAck('send_message', {
                                  //   // 'userId': singleUser.id,
                                  //   // 'senderId': senderId,
                                  //   'senderId': userId,
                                  //   'receiverId': receiverId,
                                  //   'message': message,
                                  //   'senderPersonalId': userPersonalId,
                                  //   // 'receiverId': recipientUserId,
                                  // }, ack: (response) {
                                  //   if (response != null) {
                                  //     debugPrint('Message delivered to server');
                                  //     debugPrint('from server $response');
                                  //   } else {
                                  //     debugPrint(
                                  //         'Failed to deliver the message');
                                  //   }
                                  // });

                                  if (singleUser.id != null) {
                                    await _saveConversation(singleUser.id!);
                                  }

                                  await _clearDraft(singleUser.id.toString());
                                  _controller.clear();
                                }
                              }
                            },
                            icon: Icon(
                              _controller.text.isNotEmpty
                                  ? Icons.send
                                  : Icons.mic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                show ? emojiSelect() : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      textEditingController: _controller,
    );
  }
}
