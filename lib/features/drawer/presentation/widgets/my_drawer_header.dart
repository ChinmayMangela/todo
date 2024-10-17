import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/helper_functions.dart';

class MyDrawerHeader extends StatelessWidget {
  const MyDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).colorScheme.brightness == Brightness.dark;
    User? currentUser = FirebaseAuth.instance.currentUser!;
    return DrawerHeader(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.only(top: 0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.person, size: Utils.getScreenHeight(context) * 0.1,),
              const SizedBox(height: 15),
              Text(currentUser.email!, style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: isDarkTheme ? Colors.white : Colors.black
              ),),
            ],
          ),
        ));
  }
}
