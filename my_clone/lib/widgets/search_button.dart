import 'package:flutter/material.dart';
import 'package:my_clone/widgets/numeric_keyboard.dart';

class SearchButton extends StatefulWidget {
  final String page;
  final IconData sufIcon;
  final String hintxt;
  final VoidCallback onBackPressed;
  final ValueChanged<String>? onSearchChanged;
  const SearchButton(
      {super.key,
      required this.page,
      required this.onBackPressed,
      required this.hintxt,
      required this.sufIcon,
      this.onSearchChanged});

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  String searchText = ''; // Variable to hold the text input
  bool isNumeric = false;

  final TextEditingController _controller =
      TextEditingController(); // Controller to clear the text
  PersistentBottomSheetController? _bottomSheetController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0, // Adjust as needed
      child: TextField(
        controller: _controller,
        readOnly: isNumeric,
        decoration: InputDecoration(
          hintText: widget.hintxt,
          hintStyle: const TextStyle(fontSize: 14),
          prefixIcon: IconButton(
            onPressed: () {
              widget.onBackPressed();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          suffixIcon: searchText.isNotEmpty && widget.page == 'home'
              ? IconButton(
                  icon: Icon(widget.sufIcon),
                  onPressed: () {
                    _controller.clear(); // Clear the text field
                    setState(() {
                      searchText = ''; // Reset the text state
                    });
                  },
                )
              : widget.page == 'contact'
                  ? IconButton(
                      onPressed: _showNumericKeyboard,
                      icon: isNumeric
                          ? const Icon(Icons.keyboard_alt_outlined)
                          : Icon(widget.sufIcon),
                    )
                  : null, // Show cancel button only if there's text
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
        ),
        onChanged: (value) {
          setState(() {
            searchText = value; // Update the text state
          });
          if (widget.onSearchChanged != null) {
            widget.onSearchChanged!(value); // Notify parent of changes
          }
        },
        // change later if need
      ),
    );
  }

  void _showNumericKeyboard() {
    setState(() {
      isNumeric = !isNumeric;
    });

    if (isNumeric) {
      _bottomSheetController = showBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (_) => NumericKeyboard(
          onKeyPressed: (value) {
            if (value == 'DEL') {
              if (searchText.isNotEmpty) {
                setState(() {
                  searchText = searchText.substring(0, searchText.length - 1);
                  _controller.text = searchText;
                });
              }
            } else {
              setState(() {
                searchText += value;
                _controller.text = searchText;
              });
            }
          },
        ),
      );
    } else {
      _bottomSheetController?.close();
      _bottomSheetController = null;
    }
  }
}
