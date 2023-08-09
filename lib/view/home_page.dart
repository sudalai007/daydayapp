import 'package:daydayapp/provider/service_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../common/show_model.dart';
import '../widget/card_todo_widget.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchDataProvider);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber.shade200,
              radius: 25,
              child: Image.asset('images/bruce.jpg'),
            ),
            title: Text(
              'Hello I\'m',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            ),
            subtitle: Text(
              'Sudalaimani',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(CupertinoIcons.calendar)),
                    IconButton(
                        onPressed: () {}, icon: Icon(CupertinoIcons.bell)),
                  ],
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today\'s Task",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "Wednesday, 11 May",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD5E8FA),
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    context: context,
                    builder: (context) => AddNewTaskModel(),
                  ),
                  child: const Text("+ New Task"),
                )
              ],
            ),
            const Gap(20),
            ListView.builder(
              itemCount: todoData.value?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, Index) =>
                  CardToolListWidget(getIndex: Index),
            )
          ]),
        )));
  }
}
