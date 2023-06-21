import 'package:boong3/services/local.dart';
import 'package:boong3/utils/color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Get user
    String username = '', displayName = '', profilePic = '', email = '';

  getCurrentUserData() async {
    username = await SharedPreferencesHelper().getUserName();
    displayName = await SharedPreferencesHelper().getDisplayName();
    profilePic = await SharedPreferencesHelper().getUserProfileUrl();
  }

  onLoad() async {
    await getCurrentUserData();
    setState(() {});
  }

  @override
  void initState() {
    onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: const Text(
          "Boong",
          style: TextStyle(
            fontFamily: "Bellota",
            color: subColor,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 33,
          ),
        ),
        // leading: GestureDetector(onTap: AuthHandler().signOutButton()),
      ),
      body: Container(
        color: mainColor,
      ),
    );
  }
}
