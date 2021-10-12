import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:redditech/services/base.service.dart';

/// [AuthService]
/// This is a basic classe to provide some firebase_auth's utilities
class AuthService extends BaseService {
  Future signUpWithMailAndPassword(
    String mail,
    String password,
  ) async {}

  Future signOut(Function? afterSignOut) async {}
}
