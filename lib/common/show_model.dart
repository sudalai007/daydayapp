import 'package:daydayapp/model/todo_model.dart';
import 'package:daydayapp/provider/date_time_provider.dart';
import 'package:daydayapp/provider/radio_provider.dart';
import 'package:daydayapp/provider/service_provider.dart';
import 'package:daydayapp/widget/date_time_widget.dart';
import 'package:daydayapp/widget/radio_widget.dart';
import 'package:daydayapp/widget/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../constants/app_style.dart';

class AddNewTaskModel extends ConsumerWidget {
  AddNewTaskModel({
    super.key,
  });

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    return Container(
      padding: EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "New Task Todo",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          Divider(thickness: 1.2, color: Colors.grey.shade200),
          const Gap(12),
          const Text("Title Task", style: AppStyle.headingOne),
          const Gap(6),
          TextFieldWidget(
            hinttext: "Add Task Name",
            maxLine: 1,
           txtController: titleController,
          ),
          const Gap(12),
          Text(
            "Description",
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          TextFieldWidget(
            hinttext: "Add Description",
            maxLine: 5,
            txtController: descriptionController,
          ),
          const Gap(12),
          Text(
            'Category',
            style: AppStyle.headingOne,
          ),
          Row(
            children: [
              Expanded(
                  child: RadioWidget(
                categColor: Colors.green,
                titleRadio: 'LKN',
                valueInput: 1,
                onChangeValue: () =>
                    ref.read(radioProvider.notifier).update((state) => 1),
              )),
              Expanded(
                  child: RadioWidget(
                      categColor: Colors.blue.shade700,
                      titleRadio: 'WRK',
                      valueInput: 2,
                      onChangeValue: () => ref
                          .read(radioProvider.notifier)
                          .update((state) => 2))),
              Expanded(
                  child: RadioWidget(
                      categColor: Colors.amber.shade700,
                      titleRadio: 'GEN',
                      valueInput: 3,
                      onChangeValue: () => ref
                          .read(radioProvider.notifier)
                          .update((state) => 3))),
            ],
          ),
          const Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                titleText: "Date",
                valueText: dateProv,
                iconSection: CupertinoIcons.calendar,
                onTap: () async {
                  final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2025));

                  if (getValue != null) {
                    final format = DateFormat.yMd();
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => format.format(getValue));
                  }
                },
              ),
              const Gap(22),
              DateTimeWidget(
                  titleText: "Time",
                  valueText: ref.watch(timeProvider),
                  iconSection: CupertinoIcons.clock,
                  onTap: () async {
                    final getTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (getTime != null) {
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => getTime.format(context));
                    }
                  }),
            ],
          ),
          Gap(20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade800,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.blue.shade800),
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
              ),
              const Gap(20),
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () {
                      final getRadioValue = ref.read(radioProvider);
                      String category = '';

                      switch (getRadioValue) {
                        case 1:
                          category = 'Learning';
                          break;
                        case 2:
                          category = 'Working';
                          break;
                        case 3:
                          category = 'General';
                          break;
                      }

                      ref.read(serviceProvider).addNewTask(TodoModel(
                          titleTask: titleController.text,
                          description: descriptionController.text,
                          category: category,
                          dateTask: ref.read(dateProvider),
                          timeTask: ref.read(timeProvider),
                          isDone: false));

                      print('Data is saving');

                      titleController.clear();
                      descriptionController.clear();
                      ref.read(radioProvider.notifier).update((state) => 0);
                      Navigator.pop(context);
                    },
                    child: Text("Create")),
              )
            ],
          )
        ]),
      ),
    );
  }
}
