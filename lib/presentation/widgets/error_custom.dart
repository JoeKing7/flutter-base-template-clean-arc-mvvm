import 'package:flutter/material.dart';

class CustomWidgetError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomWidgetError({
    super.key,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: Colors.red,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Oops algo no estuvo bien...",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
