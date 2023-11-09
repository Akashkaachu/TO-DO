import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onsave;
  final void Function()? oncancel;
  ShowDialog(
      {super.key,
      required this.controller,
      required this.onsave,
      required this.oncancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow.shade200,
      // ignore: sized_box_for_whitespace
      content: Container(
        height: 120,
        child: Column(children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Add New Notes"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: onsave,
                  // ignore: sort_child_properties_last
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      disabledBackgroundColor: Colors.red)),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: oncancel,
                // ignore: sort_child_properties_last
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              )
            ],
          )
        ]),
      ),
    );
  }
}
