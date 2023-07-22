import 'package:flutter/material.dart';
import 'package:pocket_base/core/utils/constants.dart';

class AppTemplate extends StatelessWidget {
  const AppTemplate({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: md, vertical: lg),
          child: child,
        ),
      ),
    );
  }
}
