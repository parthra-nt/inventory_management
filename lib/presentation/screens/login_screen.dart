import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder:
          (context, provider, child) => LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;

              // Determine width based on screen size
              double containerWidth;
              if (maxWidth < 600) {
                // Small screen (mobile) — use 90% width
                containerWidth = maxWidth * 0.9;
              } else if (maxWidth < 900) {
                // Medium screen (tablet) — use 50% width
                containerWidth = maxWidth * 0.5;
              } else {
                // Large screen (desktop) — limit max width for readability
                containerWidth = 400.w; // Fixed width scaled for large screens
              }

              return Scaffold(
                body: Stack(
                  children: [
                    Container(
                      width: maxWidth,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Center(
                      child:
                          provider.loading
                              ? const CircularProgressIndicator()
                              : SingleChildScrollView(
                                child: Container(
                                  width: containerWidth,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                  ),
                                  padding: EdgeInsets.all(24.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 8,
                                        offset: Offset(2, 4),
                                      ),
                                    ],
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "LOGIN",
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30.sp,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          "Login to Manage Your Inventory",
                                          style: TextStyle(
                                            color: AppColors.cardTextColor,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter email';
                                            }
                                            return null;
                                          },
                                          controller: provider.emailController,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.email_outlined,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            labelText: 'Email',
                                            hintText: 'sample@gmail.com',
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                        SizedBox(height: 16.h),
                                        TextFormField(
                                          obscureText: provider.isObscure,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter password';
                                            }
                                            return null;
                                          },
                                          controller: provider.otpController,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock_outline,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                provider.isObscure
                                                    ? CupertinoIcons
                                                        .eye_slash_fill
                                                    : CupertinoIcons.eye_fill,
                                              ),
                                              onPressed: provider.obscure,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                            labelText: 'Password',
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed:
                                                () async => await provider
                                                    .verifyEmailPassword(
                                                      context,
                                                    ),
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 14.h,
                                              ),
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                            ),
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
