import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/provider/auth.provider.dart';
import 'package:movie_app/views/home/page/profile/widgets/edit.icon.dart';
import 'package:provider/provider.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircleAvatar(
          radius: 35,
          child: Icon(
            Icons.person,
          ),
        ),
        const SizedBox(width: 10),
        Consumer<AuthProvider>(builder: (_, provider, __) {
          var isGuest = provider.isGuestUser;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              !isGuest
                  ? Text(
                      user.displayName!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const Text(
                      'Guest',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              const SizedBox(height: 5),
              if (!isGuest)
                Text(
                  user.email!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w200, color: Colors.grey),
                ),
              const SizedBox(height: 8),
              if (!isGuest)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.amber,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
          );
        }),
        const Spacer(),
        const EditIcon(),
      ],
    );
  }
}
