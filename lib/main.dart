import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fixmasters_user_app/bindings/root_bindings.dart';
import 'package:fixmasters_user_app/controller/bottom_nav_controller.dart';
import 'package:fixmasters_user_app/controller/chatController.dart';
import 'package:fixmasters_user_app/view/screens/auth_screen/loginPage.dart';
import 'package:fixmasters_user_app/view/screens/auth_screen/otpPage.dart';
import 'package:fixmasters_user_app/view/screens/auth_screen/signupPage.dart';
import 'package:fixmasters_user_app/view/screens/category_screen/categoryPage.dart';
import 'package:fixmasters_user_app/view/screens/chat_screen/chatPage.dart';
import 'package:fixmasters_user_app/view/screens/home_screen/homePage.dart';
import 'package:fixmasters_user_app/view/screens/profile_screen/profilePage.dart';
import 'package:fixmasters_user_app/view/screens/search_screen/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller/authController.dart';
import 'controller/userController.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await dotenv.load(fileName: ".env");
  Get.put(AuthController());
  Get.put(UserController());
  Get.put(ChatController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavigationController navigationController = Get.put(BottomNavigationController());
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top],
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xff424242).withOpacity(0.002),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),

      child: GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => HomePage(),transition: Transition.fade),
          GetPage(name: '/login', page: () => LoginPage(),transition: Transition.fadeIn),
          GetPage(name: '/signup', page: () => SignupPage(),transition: Transition.fadeIn),
          GetPage(name: '/category', page: () => CategoryPage(),transition: Transition.rightToLeftWithFade),
          GetPage(name: '/search', page: () => SearchPage(),transition: Transition.fadeIn),
          GetPage(name: '/profile', page: () => ProfilePage(),transition: Transition.fadeIn),
          GetPage(name: '/chat', page: () => ChatPage(),transition: Transition.fadeIn)
        ],
        initialBinding: RootBindings(),
        title: 'FixMasters',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange, brightness: Brightness.light),
          useMaterial3: false,
          fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold
            ),
              bodyLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              )
              // titleSmall: TextStyle(
              //     fontWeight: FontWeight.bold
              // )
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              ),
            ),
          ),
        ),

        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange, brightness: Brightness.dark),
          useMaterial3: false,
          fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: TextTheme(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold
            ),
            bodyLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            )
            // titleSmall: TextStyle(
            //     fontWeight: FontWeight.bold
            // )
          ),
        ),
        home: GetX<BottomNavigationController>(builder: (controller) {
                  return controller.currentPage;
                }),

        themeMode: ThemeMode.system,
      ),
    );
  }
}
