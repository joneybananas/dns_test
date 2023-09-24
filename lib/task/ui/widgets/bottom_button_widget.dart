import 'package:flutter/material.dart';

class BottomButtonWidget extends StatelessWidget {
  final VoidCallback onPress;
  final String label;
  final IconData icon;
  const BottomButtonWidget({required this.onPress, required this.icon, super.key, this.label = ''});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          Text(label),
        ],
      ),
    );
  }
}
