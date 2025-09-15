import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class LogoSheet extends StatelessWidget {
  const LogoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 390.w,
        height: 409.h,
        decoration: BoxDecoration(
          color: AppColors.black,
          border: Border(
            top: BorderSide(width: 1.sp, color: Colors.white),
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 30.h,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select logo", style: AppTextStyles.ts16_600),
                    SizedBox(
                      width: 358.w,
                      height: 235.h,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 18.w,
                          mainAxisSpacing: 21.h,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 107.r,
                            height: 107.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/png/helm.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    CustomButton1(text: "Save"),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 24.h,
              right: 24.w,
              child: GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Image.asset(
                  'assets/png/close.png',
                  width: 34.r,
                  height: 34.r,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
