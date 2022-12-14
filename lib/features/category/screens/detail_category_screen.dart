import 'dart:convert';

import 'package:diary_app/constants/app_colors.dart';
import 'package:diary_app/constants/app_styles.dart';
import 'package:diary_app/constants/utils.dart';
import 'package:diary_app/features/category/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class DetailCategoryScreen extends StatefulWidget {
  const DetailCategoryScreen({
    super.key,
    required this.category,
  });
  final Category category;
  static const String routeName = '/detail_category_screen';

  @override
  State<DetailCategoryScreen> createState() => _DetailCategoryScreenState();
}

class _DetailCategoryScreenState extends State<DetailCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(widget.category.content);
    final FocusNode editorFocusNode = FocusNode();

    quill.QuillController noteController = quill.QuillController(
      document: quill.Document.fromJson(json),
      selection: const TextSelection.collapsed(offset: 0),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.textPrimaryColor,
          ),
        ),
        backgroundColor: AppColors.appbarColor,
        elevation: 0.3,
        automaticallyImplyLeading: false,
        title: Text(
          widget.category.title,
          style: AppStyles.medium
              .copyWith(fontSize: 18, color: AppColors.textPrimaryColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: quill.QuillEditor(
          scrollable: true,
          scrollController: ScrollController(),
          focusNode: editorFocusNode,
          padding: const EdgeInsets.all(0),
          autoFocus: false,
          readOnly: true,
          expands: false,
          showCursor: false,
          controller: noteController,
          embedBuilders: FlutterQuillEmbeds.builders(),
          customStyles: getDefaultStyles(context),
        ),
      ),
    );
  }
}
