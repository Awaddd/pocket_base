import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/components/atoms/button.dart';
import 'package:pocket_base/components/atoms/social_login.dart';
import 'package:pocket_base/components/atoms/text_field.dart';
import 'package:pocket_base/core/utils/constants.dart';
import 'package:pocket_base/state/auth_state.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    final isValid = validate([
      usernameController.text,
      passwordController.text,
    ]);

    if (isValid == false) return;

    final auth = ref.read(authstateProvider.notifier);

    auth.login(
      usernameController.text,
      passwordController.text,
    );
  }

  bool validate(List<String> strings) {
    for (final string in strings) {
      if (string.isEmpty) return false;
    }

    return true;
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return SizedBox(
      height: size.height,
      width: size.width,
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: rl),

          //
          Text(
            'Login',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),

          //
          const SizedBox(height: xl),

          //
          Column(
            children: [
              //
              AppTextField(text: 'Username', controller: usernameController),

              //
              const SizedBox(height: lg),

              //
              AppTextField(text: 'Password', controller: passwordController),

              //
              const SizedBox(height: lg),

              //
              Button(
                text: 'Login',
                onPressed: login,
              ),

              //
              const SizedBox(height: rl),

              //
              TextButton(
                onPressed: () {
                  // show login
                  ref.read(authScreenProvider.notifier).state =
                      CurrentAuthScreen.register;
                },
                child: const Text(
                  "Don't have an account?",
                ),
              )
            ],
          ),

          //
          const SizedBox(height: rl),

          //
          const SocialLogin(),
        ],
      ),
    );
  }
}
