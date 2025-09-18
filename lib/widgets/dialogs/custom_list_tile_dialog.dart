import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class CustomListTileDialog extends StatefulWidget {
  const CustomListTileDialog({
    super.key,
    required this.title,
    required this.logo,
    required this.options,
    required this.onSave,
  });

  final String title;
  final String logo;
  final List<String> options;
  final void Function(String) onSave;

  @override
  State<CustomListTileDialog> createState() => _CustomListTileDialogState();
}

class _CustomListTileDialogState extends State<CustomListTileDialog> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 358.w,
        height: 254.h,
        decoration: BoxDecoration(
          color: AppColors.grey3,
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
        child: Column(
          children: [
            SizedBox(
              width: 310.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 34.r),
                  Text(widget.title, style: AppTextStyles.ts16_600),
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: Image.asset(
                      'assets/png/close.png',
                      width: 34.r,
                      height: 34.r,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: widget.options.length,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16.h);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _selected = index;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        CustomCheckButton(
                          isSelected: _selected == index,
                          onTap: () {
                            _selected = index;
                            setState(() {});
                          },
                        ),
                        SizedBox(width: 16.w),
                        Image.asset(
                          widget.logo,
                          width: 37.r,
                          height: 37.r,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          widget.options[index],
                          style: AppTextStyles.ts12_500,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            CustomButton1(
              text: "Go",
              onTap: () {
                Navigator.of(context).pop();
                widget.onSave.call(widget.options[_selected]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
