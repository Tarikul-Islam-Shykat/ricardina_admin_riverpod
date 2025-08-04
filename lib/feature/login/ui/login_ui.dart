// features/auth/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ricardina_admin_riverpod/core/global/custom_booton_widget.dart';
import 'package:ricardina_admin_riverpod/core/global/custom_text.dart';
import 'package:ricardina_admin_riverpod/core/global/loading_screen.dart';
import 'package:ricardina_admin_riverpod/core/global/text_field_widget.dart';
import 'package:ricardina_admin_riverpod/feature/login/provider/login_state_provider.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    // Listen for state changes
    ref.listen(loginProvider, (previous, next) {
      if (next.error != null) {
        //AppSnackbar.show(message: next.error!, isSuccess: false);
      } else if (next.isAuthenticated && !next.isLoading) {
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => AdminDashboard()),
        // );
        //  AppSnackbar.show(message: "Login Successful", isSuccess: true);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.w),
        child: SizedBox(
          height:
              MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
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
                controller: loginNotifier.emailController,
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
                controller: loginNotifier.passwordController,
                hintText: "Enter Password Here",
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 5.h),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  //  onTap: () => Navigator.pushNamed(context, AppRoute.forgetScreen),
                  onTap: () {},
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
              loginState.isLoading
                  ? btnLoading()
                  : CustomButton(
                      onTap: () => loginNotifier.login(),
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
              const SizedBox(height: 10),
              CustomButton(
                onTap: () => loginNotifier.setUpValues(),
                title: Text(
                  "Fill Up Values",
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                color: AppColors.primaryColor,
              ),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15.h),
                  SizedBox(height: 5.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      smallText(
                        text:
                            "By continuing, you confirm that you are 18 years or older ",
                      ),
                      smallText(
                        text:
                            "and agree to our Terms & Conditions and Privacy Policy.",
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      smallText(text: "Don\'t have an account ? "),
                      smallText(text: "Sign Up", color: AppColors.primaryColor),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
