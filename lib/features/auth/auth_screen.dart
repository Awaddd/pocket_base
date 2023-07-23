import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/features/auth/login.dart';
import 'package:pocket_base/features/auth/register.dart';
import 'package:pocket_base/state/auth_state.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = ref.watch(authScreenProvider);

    if (screen == CurrentAuthScreen.login) return const Login();
    return const Register();
  }
}
