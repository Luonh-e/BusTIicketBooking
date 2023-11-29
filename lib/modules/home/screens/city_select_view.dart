import 'package:flutter/material.dart';

class CitySelectView extends StatelessWidget {
  final Map<String, String> items;

  const CitySelectView({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 600,
        child: SimpleDialog(
          title: const Text(
            'Select a city',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: items.entries.map((MapEntry<String, String> entry) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, entry.key);
              },
              child: Text(
                entry.value,
                style: const TextStyle(fontSize: 17),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
