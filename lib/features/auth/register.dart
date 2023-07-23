import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/components/atoms/button.dart';
import 'package:pocket_base/components/atoms/social_login.dart';
import 'package:pocket_base/components/atoms/text_field.dart';
import 'package:pocket_base/core/utils/constants.dart';
import 'package:pocket_base/state/auth_state.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> register() async {
    final isValid = validate([
      nameController.text,
      usernameController.text,
      passwordController.text,
      confirmPasswordController.text,
    ]);

    if (isValid == false) return;

    final auth = ref.read(authProvider.notifier);

    auth.register(
      nameController.text,
      usernameController.text,
      passwordController.text,
      confirmPasswordController.text,
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
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
            'Register',
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
              AppTextField(text: 'Name', controller: nameController),

              //
              const SizedBox(height: lg),

              //
              AppTextField(text: 'Username', controller: usernameController),

              //
              const SizedBox(height: lg),

              //
              AppTextField(text: 'Password', controller: passwordController),

              //
              const SizedBox(height: lg),

              //
              AppTextField(
                text: 'Confirm Password',
                controller: confirmPasswordController,
              ),

              //
              const SizedBox(height: lg),

              //
              Button(
                text: 'Register',
                onPressed: register,
              ),

              //
              const SizedBox(height: rl),

              //
              TextButton(
                onPressed: () {
                  ref.read(authScreenProvider.notifier).state =
                      CurrentAuthScreen.login;
                },
                child: const Text(
                  "Already have an account?",
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
