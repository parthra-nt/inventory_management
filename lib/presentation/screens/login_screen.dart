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
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder:
          (context, provider, child) => Scaffold(
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
                            width: 300.w,
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
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(width: 1.w),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(width: 1.w),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(width: 1.w),
                                ),
                                labelText: 'Email',
                                hintText: "sample@gmail.com",
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                            child: SizedBox(
                              width: 300.w,
                              child: TextFormField(
                                obscureText: provider.isObscure,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Valid Password';
                                  }
                                  return null;
                                },
                                controller: provider.otpController,
                                decoration: InputDecoration(
                                  suffixIcon:
                                      provider.isObscure
                                          ? IconButton(
                                            onPressed: provider.obscure,
                                            icon: Icon(
                                              CupertinoIcons.eye_slash_fill,
                                            ),
                                          )
                                          : IconButton(
                                            onPressed: provider.obscure,
                                            icon: Icon(CupertinoIcons.eye_fill),
                                          ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide(width: 1.h),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide(width: 1.w),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide(width: 1.w),
                                  ),
                                  labelText: 'Password',
                                ),
                              ),
                            ),
                          ),
                          provider.loading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                onPressed:
                                    () async => await provider
                                        .verifyEmailPassword(context),
                                child: Text('Login'),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
