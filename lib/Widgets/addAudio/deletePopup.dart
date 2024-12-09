import 'package:flutter/material.dart';

class DeletePopup extends StatelessWidget {
  final int index;
  final void Function(int) onDeleteItem;

  const DeletePopup({
    Key? key,
    required this.index,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('حذف المقطع الصوتي'),
      content: const Text('هل انت متأكد من انك تريد حذف المقطع الصوتي؟'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('الغاء'),
        ),
        TextButton(
          onPressed: () {
            onDeleteItem(index); // Trigger the deletion action
            Navigator.of(context).pop();
          },
          child: const Text(
            'حذف',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }


}

/// Helper method to show the delete popup.
Future<void> showDeletePopup({
  required BuildContext context,
  required int index,
  required Function(int) onDeleteItem,
}) {
  return showDialog(
    context: context,
    builder: (context) => DeletePopup(
      index: index,
      onDeleteItem: onDeleteItem,
    ),
  );
}