import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sport_tournament_manager/utils/utils.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        SizedBox(
          width: 358.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: context.pop,
                child: Image.asset(
                  'assets/png/back.png',
                  width: 26.r,
                  height: 24.r,
                  fit: BoxFit.fill,
                ),
              ),
              Text("Create a tournament", style: AppTextStyles.ts16_600),
              SizedBox(width: 26.r),
            ],
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          width: 358.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tournament information", style: AppTextStyles.ts14_600),
              Text(
                "1/4",
                style: AppTextStyles.ts16_600.copyWith(
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 358.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              final isReached = index <= _page;
              return Container(
                width: 88.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: isReached ? AppColors.red : AppColors.grey2,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(child: _buildPage()),
        CustomButton1(text: 'Next', onTap: _next),
      ],
    );
  }

  Widget _buildStep1() {
    return Column(
      children: [
        Image.asset(
          'assets/png/helm.png',
          width: 107.r,
          height: 107.r,
          fit: BoxFit.fill,
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: showLogoSheet,
          child: Text("Change logo", style: AppTextStyles.ts14_400),
        ),
        SizedBox(height: 16.h),
        CustomInput1(),
        SizedBox(height: 24.h),
        SizedBox(
          width: 358.w,
          child: Text("Choose a format", style: AppTextStyles.ts16_600),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: 358.w,
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: List.generate(
              8,
              (index) => Container(
                decoration: BoxDecoration(
                  color: AppColors.grey2,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 8.h),
                child: Text('$index index', style: AppTextStyles.ts16_400),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      children: [
        ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return Center(
              child: ListTileItem(
                onEdit: () => showInputDialog(
                  title: 'Enter the team name',
                  onSave: (value) {},
                ),
                onDelete: () => showConfirmationDialog(
                  title: 'Are you sure you want\nto delete the command?',
                  onDelete: () {},
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 358.w,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Add team",
              style: AppTextStyles.ts16_600.copyWith(
                color: AppColors.red,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      children: [
        ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return Center(
              child: ListTileItem(
                onEdit: () => showInputDialog(
                  title: 'Enter the player name',
                  onSave: (value) {},
                ),
                onDelete: () => showConfirmationDialog(
                  title: 'Are you sure you want\nto delete the player?',
                  onDelete: () {},
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 358.w,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Add player",
              style: AppTextStyles.ts16_600.copyWith(
                color: AppColors.red,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      children: [
        ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return Center(
              child: ListTileItem(
                onEdit: () => showInputDialog(
                  title: 'Enter the location name',
                  onSave: (value) {},
                ),
                onDelete: () => showConfirmationDialog(
                  title: 'Are you sure you want\nto delete the location?',
                  onDelete: () {},
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: 358.w,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Add location",
              style: AppTextStyles.ts16_600.copyWith(
                color: AppColors.red,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _next() {
    switch (_page) {
      case 0:
        showNumberPickerDialog(
          title: 'Enter the number of teams',
          onSave: (value) {},
        );
        break;
      case 1:
        showNumberPickerDialog(
          title: 'Enter the number of players',
          onSave: (value) {},
        );
        break;
      case 2:
        showNumberPickerDialog(
          title: 'Enter the number of locations',
          onSave: (value) {},
        );
        break;
      case 3:
        showNumberPickerDialog(
          title: 'Enter the number of tournaments',
          onSave: (value) {},
        );
        break;
    }

    _page++;
    setState(() {});
  }

  void showLogoSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const LogoSheet();
      },
    );
  }

  void showInputDialog({
    required String title,
    required void Function(String) onSave,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: EnterTextDialog(text: title, onSave: onSave),
        );
      },
    );
  }

  void showConfirmationDialog({required String title, VoidCallback? onDelete}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: ConfirmationDialog(title: title, onDelete: onDelete),
        );
      },
    );
  }

  void showNumberPickerDialog({
    required String title,
    required void Function(int) onSave,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CustomNumberPickerDialog(title: title, onSave: onSave),
        );
      },
    );
  }

  Widget _buildPage() => switch (_page) {
    0 => _buildStep1(),
    1 => _buildStep2(),
    2 => _buildStep3(),
    3 => _buildStep4(),
    _ => SizedBox(),
  };
}
