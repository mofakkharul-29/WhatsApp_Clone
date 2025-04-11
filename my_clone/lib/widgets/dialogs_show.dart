import 'package:flutter/material.dart';

class DialogsShow {
  BuildContext? context;
  String? image;
  String? name;

  DialogsShow({required this.context, required this.image, required this.name});

  DialogsShow.showAlignedDialog(BuildContext context, String image, String n) {
    showDialog(
      context: context,
      builder: (context) => Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Material(
            // color: Colors.grey[100],
            color: Colors.transparent,
            child: Container(
              height: 270,
              width: 230,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: InkWell(
                          //if i want to make the name tappable then wrap it with inkwell with same thing so that it opens photo
                          onTap: () {},
                          child: Container(
                            width: 230,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                // image: NetworkImage(
                                //     'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                image: NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        width: 230,
                        height: 40,
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.chat_outlined,
                                color: Color(0xFF1dab61),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.call_outlined,
                                color: Color(0xFF1dab61),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.video_call_outlined,
                                color: Color(0xFF1dab61),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.info_outline_rounded,
                                color: Color(0xFF1dab61),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 230,
                      height: 30,
                      color: Colors.grey.withOpacity(0.6),
                      padding: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        n,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
