import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/components/atoms/button.dart';
import 'package:pocket_base/components/atoms/text_field.dart';
import 'package:pocket_base/core/utils/constants.dart';
import 'package:pocket_base/features/dogs/dogs_list.dart';
import 'package:pocket_base/state/dogs_state.dart';

class DogsScreen extends ConsumerStatefulWidget {
  const DogsScreen({super.key});

  @override
  ConsumerState<DogsScreen> createState() => _DogsScreenState();
}

class _DogsScreenState extends ConsumerState<DogsScreen> {
  TextEditingController dog = TextEditingController();

  Future<void> addDog() async {
    if (dog.text.isEmpty) return;
    final id = await ref.read(dogsProvider.notifier).create(dog.text);
    dog.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    final textEditingControllers = ref.read(dogsTextControllers.notifier);
    textEditingControllers.state[id] = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(height: xl),
          const Dogs(),
          const SizedBox(height: lg),
          AppTextField(text: 'Alex...', controller: dog),
          const SizedBox(height: lg),
          Button(
            onPressed: addDog,
            text: 'Add Dog',
          ),
        ],
      ),
    );
  }
}
