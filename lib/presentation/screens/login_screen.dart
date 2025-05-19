import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:untitled/constants/app_constant.dart';
import 'package:untitled/providers/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder:
          (context, provider, child) => LayoutBuilder(
            builder: (context, constraints) {
              double width =
                  constraints.maxWidth < 800 ? 800 : constraints.maxWidth;
              double height =
                  constraints.maxHeight < 500 ? 500 : constraints.maxHeight;
              return Scaffold(
                body: Stack(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        child: Container(
                          height: 550.h,
                          width: 600.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 1,
                                spreadRadius: 0.5,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Login to Manage Your Inventory",
                                  style: TextStyle(
                                    color: AppColors.cardTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Email';
                                    }
                                    return null;
                                  },
                                  controller: provider.emailController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(width: 1),
                                    ),
                                    labelText: 'Email',
                                    hintText: "sample@gmail.com",
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              if (provider.otpSent)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    width: 300,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(6),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter OTP';
                                        }
                                        return null;
                                      },
                                      controller: provider.otpController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide(width: 1),
                                        ),
                                        labelText: 'OTP',
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 20),
                              provider.loading
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                    onPressed:
                                        provider.otpSent
                                            ? () async => await provider
                                                .verifyOtp(context)
                                            : () async =>
                                                await provider.sendOtp(context),
                                    child: Text(
                                      provider.otpSent
                                          ? 'Verify OTP'
                                          : 'Send OTP',
                                    ),
                                  ),
                              Text(
                                provider.timeRemaining > 0
                                    ? 'Resend OTP in ${provider.timeRemaining} seconds'
                                    : '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
