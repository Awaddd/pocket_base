import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/models/user.dart';
import 'package:pocket_base/state/state.dart';
import 'package:pocketbase/pocketbase.dart';

enum CurrentAuthScreen { login, register }

final authScreenProvider =
    StateProvider<CurrentAuthScreen>((ref) => CurrentAuthScreen.login);

final authstateProvider = StateNotifierProvider<AuthStateNotifier, User?>(
  (ref) => AuthStateNotifier(ref),
);

class AuthStateNotifier extends StateNotifier<User?> {
  AuthStateNotifier(this.ref) : super(null);

  final Ref ref;

  void setCurrentUser(RecordModel record) {
    final user = User.fromNetwork(record);
    state = user;
  }

  void registerListener() {
    final pb = ref.read(pocketbase);
    pb.authStore.onChange.listen((event) {
      if (event.model != null) setCurrentUser(event.model as RecordModel);
    });
  }

  Future<void> login(String username, String password) async {
    final collection = ref.read(pocketbase).collection('users');
    await collection.authWithPassword(username, password);
  }

  Future<void> register(
    String name,
    String username,
    String password,
    String confirmPassword,
  ) async {
    try {
      final body = {
        'username': username,
        'password': password,
        'passwordConfirm': confirmPassword,
        'name': name,
      };

      final collection = ref.read(pocketbase).collection('users');
      await collection.create(body: body);

      await login(username, password);

      //
    } catch (err) {
      // ignore: avoid_print
      print('error: $err');
    }
  }

  void logout() {
    final pb = ref.read(pocketbase);
    pb.authStore.clear();
    state = null;
  }
}
