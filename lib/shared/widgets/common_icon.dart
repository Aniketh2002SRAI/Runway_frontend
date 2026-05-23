import 'package:flutter/material.dart';

class CommonIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double size;
  const CommonIcon({
    super.key,
    required this.icon,
    this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color ?? , size: size);
  }
}
