import 'package:boong3/services/local.dart';
import 'package:boong3/utils/color.dart';
import 'package:boong3/widgets/drawer.dart';
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
    email = await SharedPreferencesHelper().getUserEmail();
  }

  onLoad() async {
    await getCurrentUserData();
    print('got user data');
    print(displayName + " " + username);
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
      drawer: NavBar(username: username, email: email, profilePic: profilePic, displayName: displayName,),
      body: const CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: mainColor,
            centerTitle: true,
            title: Text(
              "Boong",
              style: TextStyle(
                fontFamily: "Bellota",
                color: subColor,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 33,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
