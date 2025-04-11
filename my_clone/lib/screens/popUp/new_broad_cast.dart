import 'package:flutter/material.dart';

class NewBroadCast extends StatelessWidget {
  const NewBroadCast({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Broadcast'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('New Broadcast'),
      ),
    );
  }
}
