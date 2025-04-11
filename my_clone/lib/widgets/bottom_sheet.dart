import 'package:flutter/material.dart';

class MyBottomSheet {
  Widget bottomSheet(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      // padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
      height: 330,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconCreation(
                    Icons.insert_drive_file_outlined,
                    const Color.fromARGB(255, 95, 80, 172),
                    'Document',
                  ),
                  // const SizedBox(width: 40),
                  iconCreation(
                    Icons.camera_alt,
                    const Color(0xffff2e74),
                    'Camera',
                  ),
                  // const SizedBox(width: 40),
                  iconCreation(
                    Icons.insert_photo,
                    Colors.purple,
                    'Gallery',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconCreation(
                    Icons.headset,
                    Colors.orange,
                    'Audio',
                  ),
                  // const SizedBox(width: 40),
                  iconCreation(
                    Icons.location_on_rounded,
                    const Color(0xff25d366),
                    'Location',
                  ),
                  // const SizedBox(width: 40),
                  iconCreation(
                    Icons.person,
                    const Color(0xff007bfc),
                    'Contact',
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 55),
                  iconCreation(
                    Icons.bar_chart,
                    const Color(0xff02a698),
                    'Poll',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color cl, String txt) {
    return InkWell(
      splashColor: Colors.transparent, // No splash effect
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: cl,
            radius: 24,
            child: Icon(
              size: 22.0,
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            txt,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
