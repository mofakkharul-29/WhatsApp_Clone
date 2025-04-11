// PopScope(
//   canPop: false,
//   onPopInvokedWithResult: (didPop, dynamic) async {
//     if (didPop) {
//       return;
//     }

//     if (show) {
//       // Close the emoji picker
//       setState(() {
//         show = false;
//       });
//     } else {
//       // Save draft if there's text, then pop the page
//       if (_controller.text.isNotEmpty) {
//         _saveDraft(); // Save the draft automatically
//       }
//       Navigator.of(context).pop();
//     }
//   },
// );
// **************
// void _saveDraft() {
//   // Save the draft to local storage or memory
//   print("Draft saved: ${_controller.text}");
//   // Optionally, use SharedPreferences or any other storage solution
// }
// ******************
// @override
// void initState() {
//   super.initState();
//   _restoreDraft(); // Load the draft on screen initialization

//   _focusNode.addListener(() {
//     if (_focusNode.hasFocus) {
//       setState(() {
//         show = false;
//       });
//     }
//   });
// }

// void _restoreDraft() {
//   // Fetch the draft from storage
//   final savedDraft = ""; // Replace with actual draft-fetching logic
//   if (savedDraft.isNotEmpty) {
//     setState(() {
//       _controller.text = savedDraft;
//     });
//   }
// }
