import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final provider = Provider((ref) {
  return 'HELLO';
});

final futureProvider = FutureProvider((ref) {
  return Future.delayed(const Duration(seconds: 3), () => 'DELAYED ');
});

final streamProvider = StreamProvider((ref) {
  return Stream.periodic(const Duration(seconds: 1), (i) => i);
});

// int型を保持するProvider
final stateProvider = StateProvider((ref) {
  return 0;
});

// Todo型を保持するStateNotifier
class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo() {
    final newTodo = Todo(title: (todos.toList()..shuffle()).first, done: false);
    state = [...state, newTodo];
  }
}

@immutable
class Todo {
  final String title;
  final bool done;

  const Todo({
    required this.title,
    required this.done,
  });

  Todo copyWith({String? title, bool? done}) {
    return Todo(
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }

  @override
  String toString() {
    return 'Todo{title: $title, done: $done}';
  }
}

final todos = [
  "買い物へいく",
  "部屋掃除",
  "公共料金を支払う",
  "なんかする",
];

// Todo型を保持するStateNotifierProvider
final todoNotifierProvider = StateNotifierProvider((ref) {
  return TodoNotifier();
});
