import 'package:flutter/material.dart';

class DrawerTile {
  final String name;
  final IconData icon;
  final void Function() onTap;

  const DrawerTile({
    required this.name,
    required this.icon,
    required this.onTap,
  });
}
