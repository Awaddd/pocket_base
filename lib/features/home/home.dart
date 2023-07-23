import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/core/utils/constants.dart';
import 'package:pocket_base/features/dogs/dogs_screen.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final title = Theme.of(context)
        .textTheme
        .headlineMedium
        ?.copyWith(fontWeight: FontWeight.w500);

    return Column(
      children: [
        //
        const SizedBox(height: xl),

        Text('Pocket Base', style: title),

        const DogsScreen(),
      ],
    );
  }
}
