import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPickerDialog extends StatefulWidget {
  final String path;
  final int index;
  final Future<void> Function(int, String, int) onPlay;

  const NumberPickerDialog({
    Key? key,
    required this.index,
    required this.path,
    required this.onPlay,
  }) : super(key: key);

  @override
  _NumberPickerDialogState createState() => _NumberPickerDialogState(index);
}

class _NumberPickerDialogState extends State<NumberPickerDialog> {
  int _selectedNumberOfRepeating = 1;
  final int index;

  _NumberPickerDialogState(this.index);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('عدد مرات التكرار')),
      content: NumberPicker(
        value: _selectedNumberOfRepeating,
        minValue: 1,
        maxValue: 10,
        onChanged: (value) {
          setState(() {
            _selectedNumberOfRepeating = value; // Update dynamically
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          // Close without selection
          child: const Text('الغاء'),
        ),
        TextButton(
          onPressed: () {
            widget.onPlay(index, widget.path, _selectedNumberOfRepeating);
            Navigator.of(context)
                .pop(_selectedNumberOfRepeating); // Return value
          },
          child: const Text('تشغيل'),
        ),
      ],
    );
  }
}

// Helper method to show the dialog
Future<void> showNumberPickerDialog(BuildContext context, int index,
    String path, Future<void> Function(int, String, int) onPlay) async {
  final result = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return NumberPickerDialog(
        index: index,
        path: path,
        onPlay: onPlay,
      );
    },
  );

  if (result != null) {
    print('Selected number: $result');
    // Perform any additional actions if needed
  }
}
