import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricardina_admin_riverpod/core/global/loading_screen.dart';
import 'package:ricardina_admin_riverpod/feature/auth/login_async/login_provider/login_asyn_provider.dart';

import '../../../../core/const/app_colors.dart';
import '../../../../core/const/image_path.dart';
import '../../../../core/global/custom_booton_widget.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/global/text_field_widget.dart';
import '../../forget_password/ui/forget_password_ui.dart';

class LoginAsyncUi extends ConsumerWidget {
  const LoginAsyncUi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginWatcher = ref.watch(loginAsynProvider);
    final logingAction = ref.read(loginAsynProvider.notifier);

    ref.listen(loginAsynProvider, (previous, next) {
      next.when(
        data: (isAuthenticated) {
          if (isAuthenticated) {
            // Navigate to dashboard
            // Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(builder: (context) => AdminDashboard()),
            // );
            // AppSnackbar.show(message: "Login Successful", isSuccess: true);
          }
        },
        loading: () {
          // Loading state - handled in UI
        },
        error: (error, stackTrace) {
          // Show error message
          // AppSnackbar.show(message: error.toString(), isSuccess: false);
          // ScaffoldMessenger.of(
          //   context,
          // ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Center(
              child: Image.asset(
                ImagePath.smallLogo,
                width: 71.w,
                height: 48.h,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            Center(child: headingText(text: "Sign In Account")),
            const SizedBox(height: 4),
            Center(
              child: smallText(
                text:
                    "Start your journey in playmate with fun, interactive lessons now",
                maxLines: 2,
                textAlign: TextAlign.center,
                color: AppColors.grayColor,
              ),
            ),
            SizedBox(height: 15.h),
            normalText(text: 'Email'),
            SizedBox(height: 5.h),
            CustomAuthField(
              radiusValue2: 15,
              radiusValue: 15,
              controller: logingAction.emailController,
              hintText: "Enter Email Here",
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15.h),
            normalText(text: 'Password'),
            SizedBox(height: 5.h),
            CustomAuthField(
              radiusValue2: 15,
              radiusValue: 15,
              obscureText: true,
              controller: logingAction.passwordController,
              hintText: "Enter Password Here",
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 5.h),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ForgetPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  "Forgot Password",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            loginWatcher.when(
              data: (_) => CustomButton(
                onTap: () => logingAction.login(),
                title: Text(
                  "Log In",
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                color: AppColors.primaryColor,
              ),
              error: (_, __) => CustomButton(
                onTap: () => logingAction.login(),
                title: Text(
                  "Log In",
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                color: AppColors.primaryColor,
              ),
              loading: () => btnLoading(),
            ),
          ],
        ),
      ),
    );
  }
}
