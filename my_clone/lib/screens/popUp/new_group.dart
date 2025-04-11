import 'package:flutter/material.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Group'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('New Group'),
      ),
    );
  }
}
