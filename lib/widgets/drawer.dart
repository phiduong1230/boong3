// ignore_for_file: must_be_immutable

import 'package:boong3/utils/color.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  NavBar(
      {Key? key,
      required this.displayName,
      required this.username,
      required this.email,
      required this.profilePic}) : super(key: key);
  String displayName;
  String username;
  String email;
  String profilePic;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: mainColor,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Drawer header
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/profile"),
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  radius: 20,
                  child: ClipOval(child: Image.network(widget.profilePic, width: 90, height: 90,)),
                ),
                accountName: Text(widget.displayName),
                accountEmail: Text(widget.email),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.popAndPushNamed(context, "/home"),
              child: const Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: subColor,
                  ),
                  Text(
                    "Homepage",
                    style: TextStyle(
                      color: subColor,
                      fontFamily: "Bellota",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
