import 'package:flutter/material.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomBg(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(child: child),
            CustomNavBar(),
          ],
        ),
      ),
    );
  }
}
