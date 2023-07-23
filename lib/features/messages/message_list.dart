import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/state/messages_state.dart';

class MessageList extends ConsumerStatefulWidget {
  const MessageList({super.key});

  @override
  ConsumerState<MessageList> createState() => _MessageListState();
}

class _MessageListState extends ConsumerState<MessageList> {
  void Function()? unsubscribe;

  @override
  void initState() {
    super.initState();

    (() async {
      final notifier = ref.read(messagesProvider.notifier);
      await notifier.load();
      unsubscribe = await notifier.subscribe();
    })();
  }

  @override
  void dispose() {
    super.dispose();
    if (unsubscribe == null) return;
    unsubscribe!();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesProvider);

    if (messages.isEmpty) {
      return const Center(child: Text('No messages'));
    }

    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return ListTile(
            title: Text(message.text),
          );
        },
      ),
    );
  }
}
