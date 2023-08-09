import 'package:daydayapp/provider/service_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CardToolListWidget extends ConsumerWidget {
  const CardToolListWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchDataProvider);
    return todoData.when(
        data: (todoData) {
          Color categoryColor = Colors.white;

          final getCategory = todoData[getIndex].category;

          switch (getCategory) {
            case 'Learning':
              categoryColor = Colors.green;
              break;

            case 'Working':
              categoryColor = Colors.blue.shade700;
              break;

            case 'General':
              categoryColor = Colors.amber.shade700;
              break;
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            child: Row(children: [
              Container(
                decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                ),
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.delete),
                          onPressed: () => ref
                              .read(serviceProvider)
                              .deleteTask(todoData[getIndex].docID),
                        ),
                        title: Text(
                          todoData[getIndex].titleTask,
                          maxLines: 1,
                          style: TextStyle(
                              decoration: todoData[getIndex].isDone
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        subtitle: Text(
                          todoData[getIndex].description,
                          maxLines: 1,
                          style: TextStyle(
                              decoration: todoData[getIndex].isDone
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              activeColor: Colors.blue.shade800,
                              shape: const CircleBorder(),
                              value: todoData[getIndex].isDone,
                              onChanged: (value) => ref
                                  .read(serviceProvider)
                                  .updateTask(todoData[getIndex].docID, value),
                            )),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Container(
                          child: Divider(
                            thickness: 1.2,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(todoData[getIndex].dateTask),
                          Gap(12),
                          Text(todoData[getIndex].timeTask)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
          );
        },
        error: (error, stackTrace) => Center(
              child: Text(stackTrace.toString()),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
