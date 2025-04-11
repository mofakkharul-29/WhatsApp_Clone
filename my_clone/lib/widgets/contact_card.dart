import 'package:flutter/material.dart';
import 'package:my_clone/data/model/users_model.dart';

class ContactCard extends StatelessWidget {
  final UserModel user;
  // final bool isChecked;
  const ContactCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              // backgroundColor: const Color(0xFF1dab61),
              radius: 20,
              child: user.photo != null
                  ? ClipOval(
                      child: Image.network(
                        user.photo!,
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    )
                  : const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
            ),
            user.isChecked
                ? const Positioned(
                    bottom: 12,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF1dab61),
                      radius: 9,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(
        '${user.name}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: const Text(
        'Hey there! I am using WhatsApp.',
        style: TextStyle(fontSize: 12),
      ),
      // depending on the name or number map throught the list , if they are in
      //whats app list then trailling is null or else trailling is IconButton with icon/ text as invite
      // trailing: ,
    );
  }
}
