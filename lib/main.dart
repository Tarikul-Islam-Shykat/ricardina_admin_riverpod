// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ricardina_admin_riverpod/feature/auth/auth/screen/splash_screen.dart';
import 'package:ricardina_admin_riverpod/feature/auth/login/ui/login_ui.dart';
// ... other imports

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // Wrap your app with ProviderScope
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Your design size
      builder: (context, child) {
        return MaterialApp(
          title: 'Pretty Rini',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const SplashScreen(), // Your login screen
          // ... other MaterialApp properties
        );
      },
    );
  }
}
