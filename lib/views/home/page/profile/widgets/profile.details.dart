import 'package:flutter/material.dart';
import 'package:movie_app/views/home/page/profile/widgets/edit.icon.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 35,
          child: Icon(
            Icons.person,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sivaprasad',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              '@sivaprasdnk',
              style: TextStyle(fontWeight: FontWeight.w200, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.amber,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.person,
                    size: 12,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Premium',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const Spacer(),
        const EditIcon(),
      ],
    );
  }
}
