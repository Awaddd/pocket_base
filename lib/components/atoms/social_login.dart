import 'package:flutter/material.dart';
import 'package:pocket_base/components/atoms/button.dart';
import 'package:pocket_base/core/utils/constants.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Button(
          text: 'Login with Apple',
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {},
        ),

        //
        const SizedBox(height: md),

        //
        Button(
          text: 'Login with Google',
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {},
        ),
      ],
    );
  }
}
