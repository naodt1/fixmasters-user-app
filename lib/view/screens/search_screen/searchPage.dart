import 'package:fixmasters_user_app/controller/bottom_nav_controller.dart';
import 'package:fixmasters_user_app/view/widgets/bottomNav.dart';
import 'package:fixmasters_user_app/view/widgets/customSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavigationController bottomNavigationController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
        child: Column(
          children: [
            CustomSearchBar()
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: bottomNavigationController.currentIndex.toInt(),
        onTap: (index) {
          bottomNavigationController.changePage(index);
        },
      ),
    );
  }
}
