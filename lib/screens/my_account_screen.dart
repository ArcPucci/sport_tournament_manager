import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sport_tournament_manager/providers/providers.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            SizedBox(height: 12.h),
            CustomAppBar(title: "My Account"),
            SizedBox(height: 32.h),
            value.profile == null
                ? Image.asset(
                    'assets/png/user.png',
                    width: 78.r,
                    height: 78.r,
                    fit: BoxFit.fill,
                  )
                : ClipOval(
                    child: Image.file(
                      File(value.profile!),
                      width: 78.r,
                      height: 78.r,
                      fit: BoxFit.fill,
                    ),
                  ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () async {
                final image = await getImage();
                if (image == null) return;
                value.saveImage(image);
              },
              child: Text(
                "Change photo",
                style: AppTextStyles.ts16_600.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 36.h),
            if (!value.premium)
              GestureDetector(
                onTap: () => showPremiumSheet(context),
                child: Container(
                  width: 358.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: AppColors.grey2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/png/reward.png',
                        width: 24.r,
                        height: 24.r,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Go to Premium",
                        style: AppTextStyles.ts16_400.copyWith(
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: value.deleteProfile,
              child: Container(
                width: 358.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: AppColors.grey2,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/png/trash.png',
                      width: 24.r,
                      height: 24.r,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Delete account",
                      style: AppTextStyles.ts16_400.copyWith(
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showConfirmation(BuildContext context, VoidCallback? delete) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: "Are you sure you want to\ndelete your account?",
          onDelete: delete,
        );
      },
    );
  }

  Future<File?> getImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    print('object');
    if (image == null) return null;
    return File(image.path);
  }

  void showPremiumSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return const PremiumSheet();
      },
    );
  }
}
