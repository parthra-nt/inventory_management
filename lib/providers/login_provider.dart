import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/presentation/screens/dashboard_screen.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  bool isObscure = true;
  bool loading = false;

  void obscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> verifyEmailPassword(BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      await AuthService().supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: otpController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login successful')));
    } catch (e) {
      print(e);
      showError("Please Enter Registered Email or Check The Password", context);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void showError(String msg, BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: $msg')));
  }
}
