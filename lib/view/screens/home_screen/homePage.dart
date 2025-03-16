import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixmasters_user_app/controller/handyman_controller.dart';
import 'package:fixmasters_user_app/model/handyman_model.dart';
import '../../../controller/bottom_nav_controller.dart';
import '../../../controller/chatController.dart';
import '../../../controller/userController.dart';
import '../../widgets/bottomNav.dart';
import '../../widgets/categoryCard.dart';
import '../../widgets/serviceProviderCard.dart';
import '../chat_screen/messagePage.dart';
import 'heroWidget.dart';

class HomePage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();
  final HandymanController handymanController = Get.put(HandymanController());

  List<String> imageUrl = [
    "https://static.vecteezy.com/system/resources/previews/014/401/048/non_2x/repair-works-professional-construction-service-free-vector.jpg",
    "https://cdn.iser.vc/static/articles/banners/2020/handyman1.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hello! ${userController.userData.value['fullname']}'),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications_none),
                    )
                  ],
                ),
                Text(
                  'What Service do you \nneed today?',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 16),
                HeroWidget(imageUrls: imageUrl),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories', style: Theme.of(context).textTheme.bodyText1),
                    TextButton(onPressed: () {
                      Get.toNamed('/category');
                    }, child: Text('See all'))
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: CategoryCard(iconData: Icons.format_paint, categoryName: 'Painting'),
                      ),
                      SizedBox(width: 8),
                      CategoryCard(iconData: Icons.clean_hands, categoryName: 'Cleaning'),
                      SizedBox(width: 8),
                      CategoryCard(iconData: Icons.electric_bolt, categoryName: 'Electric'),
                      SizedBox(width: 8),
                      CategoryCard(iconData: Icons.more_vert_outlined, categoryName: 'More'),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Service Providers Near you', style: Theme.of(context).textTheme.bodyText1),
                    TextButton(onPressed: () {}, child: Text('See all'))
                  ],
                ),
                SizedBox(height: 8),
                GetX<HandymanController>(
                  initState: (_) async {
                    await userController.getLocation();
                    if (userController.location.isNotEmpty) {
                      try {
                        await handymanController.fetchNearestHandymen(userController.location);
                      } catch (e) {
                        print("Error fetching handymen: $e");
                        // Handle error gracefully (display message, retry button, etc.)
                      }
                    }
                  },
                  builder: (handymanController) {
                    if (handymanController.handymens.isEmpty) {
                      return Center(
                        child: CircularProgressIndicator(), // Or any loading indicator
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: handymanController.handymens.length,
                        itemBuilder: (context, index) {
                          final serviceProvider = handymanController.handymens[index];
                          return ServiceProvidersCard(
                            key: Key(serviceProvider.uid), // Pass the uid as the key
                            serviceProviderModel: serviceProvider,
                            onTap: () {
                              Get.to(
                                MessagePage(
                                  chatUserName: serviceProvider.fullname,
                                  chatUserImg: serviceProvider.profilePic,
                                  isOnline: serviceProvider.isOnline.toString(),
                                  receiverId: serviceProvider.uid,
                                  lastActive: DateTime.now().toString()
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: Get.find<BottomNavigationController>().currentIndex.toInt(),
        onTap: (index) {
          Get.find<BottomNavigationController>().changePage(index);
        },
      ),
    );
  }
}
