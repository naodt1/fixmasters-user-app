
import 'package:fixmasters_user_app/view/screens/chat_screen/chatPage.dart';
import 'package:fixmasters_user_app/view/screens/home_screen/homePage.dart';
import 'package:fixmasters_user_app/view/screens/profile_screen/profilePage.dart';
import 'package:fixmasters_user_app/view/screens/search_screen/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {

  final List<Widget> pages = [
    HomePage(),
    SearchPage(),
    ChatPage(),
    ProfilePage()
  ];

  RxInt currentIndex = 0.obs;

  Widget get currentPage => pages[currentIndex.value];

  void changePage(int index) {
    currentIndex.value = index;
  }

  void goToHomePage() => changePage(0);
  void goToSearchPage() => changePage(1);
  void goToChatPage() => changePage(2);
  void goToProfilePage() => changePage(3);
}