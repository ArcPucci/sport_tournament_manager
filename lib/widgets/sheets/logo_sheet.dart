import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class LogoSheet extends StatefulWidget {
  const LogoSheet({super.key, required this.logo, required this.onSelected});

  final String logo;
  final void Function(String) onSelected;

  @override
  State<LogoSheet> createState() => _LogoSheetState();
}

class _LogoSheetState extends State<LogoSheet> {
  String _logo = 'assets/png/logo3.png';

  @override
  void initState() {
    super.initState();
    _logo = widget.logo;
  }

  final logos = [
    "assets/png/logo1.png",
    "assets/png/logo2.png",
    "assets/png/logo3.png",
    "assets/png/logo4.png",
    "assets/png/logo5.png",
    "assets/png/logo6.png",
  ];

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
                        itemCount: logos.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 18.w,
                          mainAxisSpacing: 21.h,
                        ),
                        itemBuilder: (context, index) {
                          final selected = logos[index] == _logo;
                          return GestureDetector(
                            onTap: () => setState(() => _logo = logos[index]),
                            child: Container(
                              width: 107.r,
                              height: 107.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: selected
                                    ? Border.all(
                                        width: 2.sp,
                                        color: AppColors.red,
                                      )
                                    : null,
                                image: DecorationImage(
                                  image: AssetImage(logos[index]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    CustomButton1(
                      text: "Save",
                      onTap: () {
                        if (_logo != widget.logo) widget.onSelected.call(_logo);
                        Navigator.of(context).pop();
                      },
                    ),
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
