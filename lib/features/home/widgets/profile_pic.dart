import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practly/core/constants.dart';
import 'package:practly/features/profile/profile_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(UserProfileScreen.route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ShadAvatar(
          FirebaseAuth.instance.currentUser?.photoURL ??
              kFallbackProfileImageUrl,
        ),
      ),
    );
  }
}
