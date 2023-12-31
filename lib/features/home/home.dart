import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/components/atoms/button.dart';
import 'package:pocket_base/core/utils/constants.dart';
import 'package:pocket_base/features/messages/message_list.dart';
import 'package:pocket_base/state/auth_state.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authProvider)!;

    void logout() => ref.read(authProvider.notifier).logout();

    final title = Theme.of(context)
        .textTheme
        .headlineMedium
        ?.copyWith(fontWeight: FontWeight.w500);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        const SizedBox(height: sm),

        Text('Hi ${user.name}', style: title),

        const SizedBox(height: xl),

        const MessageList(),

        //
        Button(text: 'Logout', onPressed: logout),
      ],
    );
  }
}
