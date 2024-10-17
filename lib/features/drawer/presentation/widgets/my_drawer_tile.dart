import 'package:flutter/material.dart';
import 'package:todo/features/drawer/models/drawer_tile.dart';

class MyDrawerTile extends StatelessWidget {
  const MyDrawerTile({super.key, required this.drawerTile,});

  final DrawerTile drawerTile;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: drawerTile.onTap,
      leading: Icon(drawerTile.icon),
      title: Text(drawerTile.name),
    );
  }
}
