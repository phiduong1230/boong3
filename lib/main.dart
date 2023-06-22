import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:boong3/screens/home.dart';
import 'package:boong3/services/auth.dart';
import 'package:boong3/utils/color.dart';
import 'package:boong3/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bắt buộc màn hình đứng
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // init firebase
  await Firebase.initializeApp();
  runApp(const StartApp());
}

class StartApp extends StatefulWidget {
  const StartApp({super.key});

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  // Lấy quyền bộ nhớ
  late Permission permission;
  PermissionStatus permissionStatus = PermissionStatus.denied;

  void getPermission() async {
    final status = await Permission.storage.status;
    setState(() {
      permissionStatus = status;
    });
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
        break;

      case PermissionStatus.granted:
        break;

      default:
        requestForPermission();
        // SystemNavigator.pop();
        break;
    }
  }

  Future<void> requestForPermission() async {
    final status = await Permission.storage.request();
    setState(() {
      permissionStatus = status;
    });
  }

  @override
  void initState() {
    //Khởi động cùng app
    getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy trạng thái đăng nhập của user
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: 'asset/images/icon.png',
        duration: 500,
        splashIconSize: 2000,
        backgroundColor: mainColor,
        nextScreen: FutureBuilder(
          future: AuthServices().getCurrentUser(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              print("snapshot has data");
              return const HomeScreen();
            } else {
              return const SignInScreen();
            }
          },
        ),
        splashTransition: SplashTransition.scaleTransition,
        // pageTransitionType: PageTransitionType.scale,
      ),
    );
  }
}
