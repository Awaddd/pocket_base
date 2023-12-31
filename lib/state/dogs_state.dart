import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/controllers/dogs_controller.dart';
import 'package:pocket_base/models/dog.dart';

final dogsTextControllers =
    StateProvider<Map<String, TextEditingController>>((ref) => {});

final dogsProvider = StateNotifierProvider<DogsNotifier, List<Dog>>((ref) {
  return DogsNotifier(ref);
});

class DogsNotifier extends StateNotifier<List<Dog>> {
  DogsNotifier(this.ref) : super([]);

  final Ref ref;

  Future<List<Dog>> fetchAll() async {
    final dogs = await DogsController(ref).fetchAll();
    return state = dogs;
  }

  Future<Dog> fetch(String id) async {
    return DogsController(ref).fetch(id);
  }

  Future<String> create(String name) async {
    final controller = DogsController(ref);
    await controller.create(name);
    final dog = await controller.fetchByName(name);

    final dogs = state.toList();
    dogs.add(dog);
    state = dogs;
    return dog.id;
  }

  Future<void> update(String id, String name) async {
    final controller = DogsController(ref);
    await controller.update(id, name);
    final dog = await controller.fetch(id);

    final index = state.indexWhere((element) => element.id == id);
    state[index] = dog;
  }

  Future<void> delete(String id) async {
    await DogsController(ref).delete(id);
    final dogs = state.toList();

    final index = state.indexWhere((element) => element.id == id);
    dogs.removeAt(index);
    state = dogs;
  }
}
