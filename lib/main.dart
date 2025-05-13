import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/constants/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/screens/home/home_screen.dart';
import 'package:untitled/provider/bottom_nav_bar_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth < 800 ? 800 : constraints.maxWidth;
        double height =
            constraints.maxHeight < 500 ? 500 : constraints.maxHeight;
        return ScreenUtilInit(
          designSize: Size(width, height),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => BottomNavBarProvider(),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.theme,
              home: HomeWebScreen(),
            ),
          ),
        );
      },
    );
  }
}
