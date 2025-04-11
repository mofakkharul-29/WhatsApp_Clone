import 'package:flutter/material.dart';

class NumericKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  const NumericKeyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    final List<String> keys = [
      '1',
      '2',
      '3',
      '-',
      '4',
      '5',
      '6',
      '.',
      '7',
      '8',
      '9',
      'DEL',
      '*#',
      '0+',
      '_',
      'SEARCH',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.grey[300],
      height: 300,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Four keys per row
            childAspectRatio: 2.0,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
          ),
          itemCount: keys.length,
          itemBuilder: (_, index) {
            String value = keys[index];
            if (value == 'DEL') {
              return GestureDetector(
                onTap: () => onKeyPressed('DEL'),
                child: Container(
                  margin: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.backspace, color: Colors.grey),
                ),
              );
            } else if (value == 'SEARCH') {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.search, color: Colors.grey),
                ),
              );
            } else if (value == '_') {
              return GestureDetector(
                onTap: () => onKeyPressed(' '),
                child: Container(
                  margin: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '_',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () => onKeyPressed(value),
                child: Container(
                  margin: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
