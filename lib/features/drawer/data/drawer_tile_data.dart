import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/features/drawer/models/drawer_tile.dart';
import 'package:todo/features/task/presentation/screens/over_due_tasks_page.dart';
import 'package:todo/main.dart';

List<DrawerTile> drawerTiles = [
  DrawerTile(
    name: 'Your Tasks',
    icon: Icons.task_sharp,
    onTap: () {
      navigatorKey.currentState!.pop();
    },
  ),
  DrawerTile(
    name: 'Overdue Tasks',
    icon: FontAwesomeIcons.hourglassEnd,
    onTap: () {
      navigatorKey.currentState!.pop();
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => OverDueTasksPage(),
        ),
      );
    },
  ),
];
