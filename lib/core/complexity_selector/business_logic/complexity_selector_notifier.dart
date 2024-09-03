import 'package:flutter/material.dart';
import 'package:practly/core/enums/enums.dart';
import 'package:practly/core/navigation/auth_notifier.dart';
import 'package:practly/core/services/remote_database_service.dart';

class ComplexitySelectorNotifier with ChangeNotifier {
  final RemoteDatabaseService _databaseService;
  final FirebaseAuthNotifier _firebaseAuthNotifier;

  ComplexitySelectorNotifier(
    this._databaseService,
    this._firebaseAuthNotifier,
  );

  Complexity _selectedComplexity = Complexity.easy;

  Complexity get selectedComplexity => _selectedComplexity;

  set selectedComplexity(Complexity value) {
    _selectedComplexity = value;

    notifyListeners();
  }

  bool _isSaving = false;

  bool get isSaving => _isSaving;

  set isSaving(bool value) {
    _isSaving = value;
  }

  void onComplexityChanged(Complexity newComplexity) {
    selectedComplexity = newComplexity;
  }

  Future<void> onSaveAndContinue() async {
    isSaving = true;

    await saveComplexity(_selectedComplexity);

    _isSaving = false;
  }

  Future<void> saveComplexity(Complexity complexity) async {
    final userId = _firebaseAuthNotifier.signedInUser!.id;

    await _databaseService.updateUserProfile(
      userId,
      {"complexity": complexity.name},
    );

    final updatedUser = await _databaseService.getUserProfile(userId);
    _firebaseAuthNotifier.updateSignedInUserNotify(updatedUser);
  }
}
