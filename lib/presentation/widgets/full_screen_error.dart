import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullScreenError extends StatelessWidget {
  /// A widget that displays a full-screen error message.
  final String title;
  final String message;
  final String? goToRoute;

  const FullScreenError(
      {super.key, required this.title, required this.message, this.goToRoute});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(title,
              style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.red) ??
                  TextStyle(color: Colors.red)),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.red[700]) ??
                  TextStyle(color: Colors.red[700]),
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
              if (goToRoute == null) {
                Get.back();
                return;
              }
              Get.toNamed(goToRoute!);
            },
            child: const Text('Aceptar'),
          ),
        ]),
      ),
    );
  }
}
