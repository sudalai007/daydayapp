import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daydayapp/model/todo_model.dart';
import 'package:daydayapp/services/todo_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceProvider = StateProvider<TodoService>((ref) {
  return TodoService();
});

final fetchDataProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('daydayApp')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TodoModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});
