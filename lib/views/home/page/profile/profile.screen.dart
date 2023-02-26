import 'package:flutter/material.dart';
import 'package:movie_app/utils/extensions/build.context.extension.dart';
import 'package:movie_app/views/common/common.button.dart';
import 'package:movie_app/views/home/page/profile/widgets/bookmark.list.menu.dart';
import 'package:movie_app/views/home/page/profile/widgets/profile.details.dart';
import 'package:movie_app/views/home/page/profile/widgets/profile.menu.card.dart';
import 'package:movie_app/views/home/page/profile/widgets/profile.section.title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var isGuest = context.authProvider.isGuestUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 25),
            ProfileDetails(isGuest: isGuest),
            const SizedBox(height: 30),
            const ProfileSectionTitle(title: 'Your Activities'),
            const SizedBox(height: 15),
            BookmarkListMenu(isGuest: isGuest),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'Reviews',
              icon: Icons.message,
              isCountItem: true,
              count: 15,
            ),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'History',
              icon: Icons.play_arrow_rounded,
            ),
            const SizedBox(height: 25),
            const ProfileSectionTitle(title: 'Theme'),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'Switch to Dark theme',
              icon: Icons.dark_mode,
              showtrailing: false,
            ),
            const SizedBox(height: 25),
            const ProfileSectionTitle(title: 'Account'),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'Settings',
              icon: Icons.settings,
            ),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'My Subscription Plan',
              icon: Icons.money,
            ),
            const SizedBox(height: 15),
            const ProfileMenuCard(
              title: 'Change Password',
              icon: Icons.lock,
            ),
            const SizedBox(height: 30),
            CommonButton(
              callback: () {
                context.authProvider.logout(context);
              },
              title: 'Sign Out',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
