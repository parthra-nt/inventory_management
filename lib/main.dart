import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled/auth/auth_service.dart';
import 'package:untitled/constants/app_constant.dart';
import 'package:untitled/presentation/screens/home/home_screen.dart';
import 'package:untitled/presentation/screens/login_screen.dart';
import 'package:untitled/providers/add_item_provider.dart';
import 'package:untitled/providers/item_page_provider.dart';
import 'package:untitled/providers/login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
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
              ChangeNotifierProvider(create: (_) => ItemPageProvider(0, '')),
              ChangeNotifierProvider(create: (_) => LoginProvider()),
              ChangeNotifierProvider(create: (_) => AddItemProvider()),
            ],
            child: MaterialApp(
              theme: AppTheme.theme,
              debugShowCheckedModeBanner: false,
              home:
                  AuthService().supabase.auth.currentUser != null
                      ? HomeWebScreen()
                      : LoginScreen(),
            ),
          ),
        );
      },
    );
  }
}
