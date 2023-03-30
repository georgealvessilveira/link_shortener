import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback? onPressed;

  const SendButton({
    Key? key,
    required this.textEditingController,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.send,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
