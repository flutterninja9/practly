import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practly/core/constants.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/di/di.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  static String get route => "/profile";

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late final FirebaseAuthNotifier authNotifier;
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    authNotifier = locator.get();
    _loadUserData();
  }

  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _displayNameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = authNotifier.signedInUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          ShadButton.ghost(
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  _saveChanges();
                }
                _isEditing = !_isEditing;
              });
            },
            child: Text(_isEditing ? 'Save' : 'Edit'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ShadAvatar(
                  user?.displayPictureUrl ?? kFallbackProfileImageUrl,
                  placeholder: Text(
                    user?.name?.substring(0, 1).toUpperCase() ?? 'U',
                    style: ShadTheme.of(context).textTheme.h2,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ShadInputFormField(
                controller: _displayNameController,
                placeholder: const Text('Display Name'),
                readOnly: !_isEditing,
                prefix: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: ShadImage.square(size: 16, LucideIcons.user),
                ),
              ),
              const SizedBox(height: 16),
              ShadInputFormField(
                controller: _emailController,
                placeholder: const Text('Email'),
                readOnly: true, // Email should not be editable
                prefix: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: ShadImage.square(size: 16, LucideIcons.mail),
                ),
              ),
              const SizedBox(height: 24),
              ShadButton.destructive(
                onPressed: _signOut,
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() async {
    try {
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(_displayNameController.text);
      const t = ShadToast.raw(
          variant: ShadToastVariant.primary,
          title: Text('Profile updated successfully'));
      if (!mounted) return;
      ShadToaster.maybeOf(context)?.show(t);
    } catch (e) {
      const t = ShadToast.destructive(title: Text('Failed to update profile'));
      if (!mounted) return;
      ShadToaster.maybeOf(context)?.show(t);
    }
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      const t = ShadToast.destructive(title: Text('Failed to sign out'));

      if (!mounted) return;
      ShadToaster.maybeOf(context)?.show(t);
    }
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
