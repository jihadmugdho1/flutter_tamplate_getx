// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petzy_optimized/core/utils/constants/enums.dart';

class MediaPicker {
  static final ImagePicker _picker = ImagePicker();

  static Future<void> show({
    required BuildContext context,
    PickerType type = PickerType.both,
    required Function(XFile?) onPicked,
  }) async {
    showDialog(
      context: context,
      builder: (dialogContext) {
        switch (type) {

          /// PHOTO ONLY
          case PickerType.photo:
            return _buildDialog(
              title: "Select Photo",
              items: [
                _item("Take Photo", () => _pickImage(dialogContext, ImageSource.camera, onPicked)),
                _item("Choose from Gallery", () => _pickImage(dialogContext, ImageSource.gallery, onPicked)),
              ],
            );

          /// VIDEO ONLY
          case PickerType.video:
            return _buildDialog(
              title: "Select Video",
              items: [
                _item("Record Video", () => _pickVideo(dialogContext, ImageSource.camera, onPicked)),
                _item("Choose from Gallery", () => _pickVideo(dialogContext, ImageSource.gallery, onPicked)),
              ],
            );

          /// BOTH
          case PickerType.both:
            return _buildDialog(
              title: "Select Media",
              items: [
                _item("Use Camera", () async {
                  Navigator.pop(dialogContext);
                  await Future.delayed(const Duration(milliseconds: 200));
                  _showSubDialog(context, true, onPicked);
                }),
                _item("Choose from Gallery", () async {
                  Navigator.pop(dialogContext);
                  await Future.delayed(const Duration(milliseconds: 200));
                  _showSubDialog(context, false, onPicked);
                }),
              ],
            );
        }
      },
    );
  }

  // ---------- SAFE SUB DIALOG ----------
  static void _showSubDialog(
    BuildContext context,
    bool isCamera,
    Function(XFile?) onPicked,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => _buildDialog(
        title: isCamera ? "Camera" : "Gallery",
        items: [
          _item(
            isCamera ? "Take Photo" : "Pick Image",
            () => _pickImage(ctx, isCamera ? ImageSource.camera : ImageSource.gallery, onPicked),
          ),
          _item(
            isCamera ? "Record Video" : "Pick Video",
            () => _pickVideo(ctx, isCamera ? ImageSource.camera : ImageSource.gallery, onPicked),
          ),
        ],
      ),
    );
  }

  // ---------- SAFE PICKERS ----------
  static Future<void> _pickImage(
    BuildContext context,
    ImageSource source,
    Function(XFile?) onPicked,
  ) async {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 200));

    final file = await _picker.pickImage(
      source: source,
      imageQuality: 70, // 🔥 important memory fix
    );

    onPicked(file);
  }

  static Future<void> _pickVideo(
    BuildContext context,
    ImageSource source,
    Function(XFile?) onPicked,
  ) async {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 200));

    final file = await _picker.pickVideo(source: source);
    onPicked(file);
  }

  // ---------- UI HELPERS ----------
  static AlertDialog _buildDialog({
    required String title,
    required List<Widget> items,
  }) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }

  static Widget _item(String text, VoidCallback onTap) {
    return ListTile(
      title: Text(text),
      onTap: onTap,
    );
  }
}