import 'package:flutter/material.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 13,
      backgroundColor: Colors.grey.withOpacity(0.4),
      child: const Icon(
        Icons.edit,
        size: 12,
        color: Colors.black,
      ),
    );
  }
}
