import 'package:flutter/material.dart';

class OwnMessageCard extends StatelessWidget {
  final String msg;
  const OwnMessageCard({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 35,
          // minWidth: 100,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: const Color(0xffdcf8c6),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 55,
                  top: 5,
                  bottom: 15,
                ),
                child: Text(
                  // 'hey sdssdfsdfasf fdsadfsafasfssf fsafasfdsfsfasfd fassfasfsafsf',
                  msg,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Row(
                  children: [
                    Text(
                      '15:30',
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.done_all,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
