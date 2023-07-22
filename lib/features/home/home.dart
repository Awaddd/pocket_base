import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/components/atoms/button.dart';
import 'package:pocket_base/components/atoms/text_field.dart';
import 'package:pocket_base/core/utils/constants.dart';
import 'package:pocket_base/features/dogs/dogs.dart';
import 'package:pocket_base/state/dogs_state.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
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
    final title = Theme.of(context)
        .textTheme
        .headlineMedium
        ?.copyWith(fontWeight: FontWeight.w500);

    return Column(
      children: [
        const SizedBox(height: xl),

        //
        Text('Pocket Base', style: title),

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
    );
  }
}