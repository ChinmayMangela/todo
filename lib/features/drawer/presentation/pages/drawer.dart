
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/drawer/presentation/widgets/my_drawer_header.dart';
import 'package:todo/features/drawer/presentation/widgets/my_drawer_tiles.dart';
import 'package:todo/utils/helper_functions.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          MyDrawerHeader(),
          MyDrawerTiles(),
        ],
      ),
    );
  }
}
