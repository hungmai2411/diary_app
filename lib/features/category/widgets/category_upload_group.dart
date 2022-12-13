import 'package:diary_app/features/category/models/category.dart';
import 'package:diary_app/features/category/screens/detail_category_screen.dart';
import 'package:diary_app/features/category/widgets/item_add_category.dart';
import 'package:diary_app/features/category/widgets/item_category.dart';
import 'package:flutter/material.dart';

class CategoryUploadGroup extends StatefulWidget {
  final List<Category> categories;

  const CategoryUploadGroup({
    super.key,
    required this.categories,
  });

  @override
  State<CategoryUploadGroup> createState() => _CategoryUploadGroupState();
}

class _CategoryUploadGroupState extends State<CategoryUploadGroup> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1,
      ),
      shrinkWrap: true,
      padding: const EdgeInsets.all(15),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.categories.isEmpty ? 1 : widget.categories.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ItemAddCategory(
            index: index,
            callback: (category) {
              setState(() {});
            },
          );
        }
        Category category = widget.categories[index - 1];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailCategoryScreen.routeName,
              arguments: category,
            );
          },
          child: ItemCategory(
            category: category,
          ),
        );
      },
    );
  }
}
