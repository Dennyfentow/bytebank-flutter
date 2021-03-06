import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionAuthDialog({required this.onConfirm});

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: TextField(
        controller: _passwordController,
        obscureText: true,
        maxLength: 4,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 64,
          letterSpacing: 24,
        ),
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              widget.onConfirm(_passwordController.text);
              Navigator.pop(context);
            },
            child: const Text('Confirm')),
      ],
    );
  }
}
