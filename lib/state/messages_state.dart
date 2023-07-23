import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/models/message.dart';
import 'package:pocket_base/state/state.dart';

final messagesProvider = StateNotifierProvider<MessagesNotifier, List<Message>>(
  (ref) => MessagesNotifier(ref),
);

class MessagesNotifier extends StateNotifier<List<Message>> {
  MessagesNotifier(this.ref) : super([]);

  final Ref ref;

  Future<void> load() async {
    final collection = ref.read(pocketbase).collection('messages');
    final messages = await collection.getList(
      page: 1,
      perPage: 50,
      sort: 'created',
    );

    if (messages.items.isEmpty) return;

    final List<Message> arr = [];

    for (final message in messages.items) {
      final msg = Message.fromNetwork(message);
      arr.add(msg);
    }

    state = arr;
  }

  Future<Future<void> Function()> subscribe() async {
    final pb = ref.read(pocketbase);

    return pb.collection('messages').subscribe('*', (e) async {
      final record = e.record;

      if (e.action == 'create' && record != null) {
        final List<Message> arr = state.toList();
        arr.add(Message.fromNetwork(record));
        state = arr;
      }
    });
  }
}
