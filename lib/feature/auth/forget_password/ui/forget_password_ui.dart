import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricardina_admin_riverpod/core/const/app_colors.dart';
import 'package:ricardina_admin_riverpod/core/const/image_path.dart';
import 'package:ricardina_admin_riverpod/core/global/custom_booton_widget.dart';
import 'package:ricardina_admin_riverpod/core/global/custom_text.dart';
import 'package:ricardina_admin_riverpod/core/global/loading_screen.dart';
import 'package:ricardina_admin_riverpod/core/global/text_field_widget.dart'
    show CustomAuthField;
import 'package:ricardina_admin_riverpod/feature/auth/forget_password/provider/forget_password_notifier.dart';
import 'package:ricardina_admin_riverpod/feature/auth/forget_password/repo/forget_password_repo.dart';

class ForgetPasswordScreen extends ConsumerWidget {
  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgetPasswordState = ref.watch(forgetPasswordProvider);
    final forgetPasswordNotifier = ref.watch(forgetPasswordProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
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
              SizedBox(height: 10.h),
              Center(child: headingText(text: "Forget Password")),
              //Center(child: authHeaderText("Forget Password",)),
              SizedBox(height: 4.h),
              Center(
                child: smallText(
                  text:
                      "Enter your email here. Give valid email to reset your password",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  color: AppColors.grayColor,
                ),
              ),
              // Center(child: authHeaderSubtitle(
              //   "Enter your email here. Give valid email to reset your password", width:320.w,)),
              SizedBox(height: 15.h),
              normalText(text: 'Email'),
              CustomAuthField(
                keyboardType: TextInputType.emailAddress,
                radiusValue: 15,
                radiusValue2: 15,
                controller: forgetPasswordNotifier.emailController,
                hintText: 'Enter Email Here',
              ),
              Spacer(),
              forgetPasswordState.when(
                data: (result) => CustomButton(
                  onTap: () => forgetPasswordNotifier.forgetPassword(),
                  title: normalText(text: "Reset Password"),
                  color: AppColors.primaryColor,
                ),
                loading: () => btnLoading(),
                error: (error, stackTrace) => CustomButton(
                  onTap: () => forgetPasswordNotifier.forgetPassword(),
                  title: normalText(text: "Reset Password"),
                  color: AppColors.redcolor,
                ),
              ), // CustomButton(
            ],
          ),
        ),
      ),
    );
  }
}
