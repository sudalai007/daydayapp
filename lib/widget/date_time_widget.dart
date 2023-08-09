import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../constants/app_style.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,
    required this.titleText,
    required this.valueText,
    required this.iconSection,
    required this.onTap,
  });

  final String titleText;
  final String valueText;
  final IconData iconSection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: AppStyle.headingOne,
        ),
        const Gap(6),
        Material(
          child: Ink(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => onTap(),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent),
                  child: Row(
                    children: [Icon(iconSection), Gap(12), Text(valueText)],
                  )),
            ),
          ),
        )
      ],
    ));
  }
}
