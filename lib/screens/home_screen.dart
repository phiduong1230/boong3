import 'package:boong3/services/auth.dart';
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
    print('got user data');
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
      drawer: Drawer(
        child: Container(
          color: mainColor,
          child: ListView(
            children: [
              Center(
                child: Image.asset(
                  'asset/images/icon_trans.png',
                  height: MediaQuery.of(context).size.height / 10,
                ),
              ),
              const Center(
                child: Row(
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
              )
            ],
          ),
        ),
      ),
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
