import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/presentation/screens/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  bool otpSent = false;
  bool loading = false;

  Future<void> sendOtp(BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      final response = await AuthService().supabase.auth.signInWithOtp(
        email: emailController.text,
      );
      otpSent = true;
      notifyListeners();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OTP sent to your email')));
      return response;
    } catch (e) {
      showError(e.toString(), context);
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> verifyOtp(BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      final response = await AuthService().supabase.auth.verifyOTP(
        type: OtpType.email,
        token: otpController.text.trim(),
        email: emailController.text.trim(),
      );

      if (response.session != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login successful')));
      } else {
        showError("Verification failed", context);
      }
    } catch (e) {
      showError(e.toString(), context);
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
