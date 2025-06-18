import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

toaster({
  required BuildContext context,
  required String title,
  required String description,
  required ToastificationType type,
  required ToastificationStyle style,
}) {
  final toast = Toastification();
  toast.show(
    autoCloseDuration: const Duration(seconds: 3),
    // ignore: use_build_context_synchronously
    context: context,
    title: Text(
      title,
    ),
    description: Text(description),
    type: type,
    style: style,
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],
    showProgressBar: false,
  );
}
