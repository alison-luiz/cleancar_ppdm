import 'package:flutter/material.dart';

class CustomNotification extends StatelessWidget {
  final String message;
  final bool isError;

  const CustomNotification({
    super.key,
    required this.message,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      left: 20,
      right: 20,
      child: Card(
        color: isError ? Colors.redAccent : Colors.greenAccent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                isError ? Icons.error : Icons.check_circle,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
