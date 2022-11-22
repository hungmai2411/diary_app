import 'package:diary_app/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ItemDate extends StatelessWidget {
  final String date;
  final Color color;
  const ItemDate({
    super.key,
    required this.date,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Text(
            date,
            style: TextStyle(color: color),
          ),
          const SizedBox(height: 5),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.unNote,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
