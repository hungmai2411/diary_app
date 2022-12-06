import 'dart:convert';

import 'package:delta_markdown/delta_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:markdown/markdown.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  static const String routeName = '/document_screen';

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  QuillController controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            QuillToolbar.basic(controller: controller),
            Expanded(
              child: QuillEditor.basic(
                controller: controller,
                readOnly: false,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final convertedValue =
              jsonEncode(controller.document.toDelta().toJson());
          final markdown = deltaToMarkdown(convertedValue);
          final html = markdownToHtml(markdown);
          Navigator.of(context).pop(html);
        },
        child: const FaIcon(
          FontAwesomeIcons.downLeftAndUpRightToCenter,
          size: 17,
        ),
      ),
    );
  }
}
