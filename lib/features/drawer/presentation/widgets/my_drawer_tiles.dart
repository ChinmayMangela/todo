import 'package:flutter/material.dart';
import 'package:todo/features/drawer/data/drawer_tile_data.dart';
import 'package:todo/features/drawer/presentation/widgets/my_drawer_tile.dart';

class MyDrawerTiles extends StatelessWidget {
  const MyDrawerTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: drawerTiles.map((drawerTile) {
        return MyDrawerTile(drawerTile: drawerTile);
      }).toList(),
    );
  }
}
