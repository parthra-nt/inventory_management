import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/presentation/screens/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController phone = TextEditingController(text: '+91');
  final TextEditingController otp = TextEditingController();
  bool toVerify = false;

  void verifyOTP(BuildContext context) async {
    try {
      await AuthService().supabase.auth.verifyOTP(
        type: OtpType.sms,
        phone: phone.text,
        token: otp.text,
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } catch (e) {
      print("Error Logging In $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Check Your OTP or Phone Number")),
      );
    }
  }

  void sendOTP(BuildContext context) async {
    try {
      await AuthService().supabase.auth.signInWithOtp(phone: phone.text);
      toVerify = !toVerify;
      notifyListeners();
    } catch (e) {
      print("Error Logging In $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Enter Registered Phone Number")),
      );
    }
  }
}
