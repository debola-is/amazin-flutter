import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String text,
  String type,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.all(15),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: type == "error"
                    ? Colors.red.shade900
                    : type == "success"
                        ? Colors.green.shade900
                        : Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 5,
            ),
          ),
          Icon(
            type == "error"
                ? Icons.error_outline_outlined
                : type == "success"
                    ? Icons.check_outlined
                    : Icons.info_outline,
            color: type == "error"
                ? const Color.fromARGB(255, 168, 0, 0)
                : type == "success"
                    ? const Color.fromARGB(255, 18, 95, 23)
                    : Colors.black,
            size: 18,
          )
        ],
      ),
      backgroundColor: type == "error"
          ? const Color.fromARGB(255, 249, 225, 227)
          : type == "success"
              ? const Color.fromARGB(255, 236, 249, 236)
              : const Color.fromARGB(255, 250, 248, 229),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

Future<List<File>> selectImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
