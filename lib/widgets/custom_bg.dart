import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sport_tournament_manager/utils/utils.dart';

class CustomBg extends StatelessWidget {
  const CustomBg({super.key, this.bg, required this.child});

  final String? bg;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Material(
        color: AppColors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (bg != null)
              Positioned.fill(child: Image.asset(bg!, fit: BoxFit.cover)),
            Positioned.fill(child: child),
          ],
        ),
      ),
    );
  }
}
