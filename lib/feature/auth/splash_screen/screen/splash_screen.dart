import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricardina_admin_riverpod/core/const/app_colors.dart';
import 'package:ricardina_admin_riverpod/core/const/image_path.dart';
import 'package:ricardina_admin_riverpod/feature/auth/splash_screen/provider/splash_notifier.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(splashProvider(context));

    // for responsiveness
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImagePath.splashLogo, height: 104, width: 153),
            Text(
              "Kudima",
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w800,
                fontSize: 60.sp,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
