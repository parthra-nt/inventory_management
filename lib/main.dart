import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/constants/app_constant.dart';
import 'package:untitled/presentation/screens/dashboard_screen.dart';
import 'package:untitled/presentation/screens/login_screen.dart';
import 'package:untitled/providers/add_item_provider.dart';
import 'package:untitled/providers/dashboard_provider.dart';
import 'package:untitled/providers/items_details_provider.dart';
import 'package:untitled/providers/login_provider.dart';

const supabaseUrl = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
const supabaseKey = String.fromEnvironment('SUPABASE_KEY', defaultValue: '');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(MyApp());
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
              ChangeNotifierProvider(create: (_) => ItemsDetailProvider()),
              ChangeNotifierProvider(create: (_) => LoginProvider()),
              ChangeNotifierProvider(create: (_) => AddItemProvider()),
              ChangeNotifierProvider(create: (_) => DashboardProvider()),
            ],
            child: MaterialApp(
              theme: AppTheme.theme,
              debugShowCheckedModeBanner: false,
              home:
                  AuthService().supabase.auth.currentUser != null
                      ? DashboardScreen()
                      : LoginScreen(),
            ),
          ),
        );
      },
    );
  }
}
