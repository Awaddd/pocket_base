import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/core/templates/template.dart';
import 'package:pocket_base/core/utils/color_schemes.g.dart';
import 'package:pocket_base/features/auth/auth_screen.dart';
import 'package:pocket_base/features/home/home.dart';
import 'package:pocket_base/state/auth_state.dart';

void main() async {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(authstateProvider.notifier).registerListener();

    final user = ref.watch(authstateProvider);

    return MaterialApp(
      title: 'Pocket Base Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      themeMode: ThemeMode.dark,
      home: AppTemplate(
        child: user == null ? const AuthScreen() : const Home(),
      ),
    );
  }
}
