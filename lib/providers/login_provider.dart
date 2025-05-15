import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/presentation/screens/home/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  Timer? timer;
  int timeRemaining = 0;
  bool otpSent = false;
  bool loading = false;

  Future<void> sendOtp(BuildContext context) async {
    loading = true;
    notifyListeners();
    try {
      var response = await AuthService().supabase.auth.signInWithOtp(
        email: emailController.text,
      );
      otpSent = true;
      timeRemaining == 0 ? startTimer() : null;
      notifyListeners();
      showOtpSentPopup(context);
      return response;
    } catch (e) {
      showError(e.toString(), context);
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void startTimer() {
    timer?.cancel(); // Cancel any existing timer
    timeRemaining = 60;
    notifyListeners();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining == 0) {
        timer.cancel();
      } else {
        timeRemaining--;
        notifyListeners();
      }
    });
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
          MaterialPageRoute(builder: (_) => HomeWebScreen()),
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

  void showOtpSentPopup(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            left: MediaQuery.of(context).size.width * 0.35,
            right: MediaQuery.of(context).size.width * 0.35,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Colors.greenAccent),
                    SizedBox(width: 1),
                    Expanded(
                      child: Text(
                        'OTP sent to your email',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );

    // Insert overlay
    overlay.insert(overlayEntry);

    // Remove after 3 seconds
    Future.delayed(Duration(seconds: 3)).then((_) => overlayEntry.remove());
  }
}
