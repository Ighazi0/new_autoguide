// ignore_for_file: use_build_context_synchronously
import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';

class SnackDialog extends StatefulWidget {
  final String? message;
  final bool error;

  const SnackDialog({super.key, required this.message, this.error = true});

  @override
  State<SnackDialog> createState() => _SnackDialogState();
}

class _SnackDialogState extends State<SnackDialog> {
  handleDissmiss() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    handleDissmiss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppStyle.borderRadius),
        alignment: Alignment.bottomCenter,
        backgroundColor: widget.error ? Colors.red : AppStyle.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.message.toString().tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
