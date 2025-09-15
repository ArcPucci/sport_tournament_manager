import 'package:flutter/material.dart';
import 'package:sport_tournament_manager/widgets/widgets.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key, required this.path, required this.child});

  final String path;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final hasNavBar = !path.contains('create');
    return CustomBg(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(child: child),
            if (hasNavBar) CustomNavBar(path: path),
          ],
        ),
      ),
    );
  }
}
