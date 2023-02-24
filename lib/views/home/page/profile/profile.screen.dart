import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 20),
          Center(
            child: Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 25),
          ProfileDetails(),
          SizedBox(height: 30),
          ProfileSectionTitle(title: 'Your Activities'),
          SizedBox(height: 15),
          ProfileMenuCard(
            title: 'Bookmark List',
            icon: Icons.bookmark,
            isCountItem: true,
            count: 15,
          ),
          SizedBox(height: 15),
          ProfileMenuCard(
            title: 'Reviews',
            icon: Icons.message,
            isCountItem: true,
            count: 15,
          ),
          SizedBox(height: 15),
          ProfileMenuCard(
            title: 'History',
            icon: Icons.play_arrow_rounded,
          ),
          SizedBox(height: 25),
          ProfileSectionTitle(title: 'Theme'),
          SizedBox(height: 15),
          ProfileMenuCard(
            title: 'Switch to Dark theme',
            icon: Icons.dark_mode,
            showtrailing: false,
          ),
          SizedBox(height: 25),
          ProfileSectionTitle(title: 'Account'),
          SizedBox(height: 15),
          ProfileMenuCard(
            title: 'Settings',
            icon: Icons.settings,
          ),
          SizedBox(height: 15),
          ProfileMenuCard(
            title: 'My Subscription Plan',
            icon: Icons.money,
          ),
          SizedBox(height: 15),
          ProfileMenuCard(
            title: 'Change Password',
            icon: Icons.lock,
          ),
        ],
      ),
    );
  }
}
