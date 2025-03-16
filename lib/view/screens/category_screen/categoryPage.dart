import 'package:fixmasters_user_app/view/widgets/customSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:fixmasters_user_app/view/widgets/categoryCard.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
        child: Column(
          children: [
            CustomSearchBar(),
            SizedBox(height: 18,),
            Expanded(child: _buildGridCategory())
          ],
        ),
      ),
    );
  }

  Widget _buildGridCategory() {
    // Mock list of categories (you can replace it with your actual data)
    List<Map<String, dynamic>> categories = [
      {"iconData": Icons.format_paint, "categoryName": "Painting"},
      {"iconData": Icons.clean_hands, "categoryName": "Cleaning"},
      {"iconData": Icons.electric_bolt, "categoryName": "Electric"},
      {"iconData": Icons.more_vert_outlined, "categoryName": "More"},
      {"iconData": Icons.format_paint, "categoryName": "Painting"},
      {"iconData": Icons.clean_hands, "categoryName": "Cleaning"},
      {"iconData": Icons.electric_bolt, "categoryName": "Electric"},
      {"iconData": Icons.more_vert_outlined, "categoryName": "More"},
      {"iconData": Icons.format_paint, "categoryName": "Painting"},
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns in the grid
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        // Access category data at the current index
        Map<String, dynamic> category = categories[index];
        return InkWell(
          onTap: () {
            // Handle category tap
          },
          child: CategoryCard(
            iconData: category['iconData'],
            categoryName: category['categoryName'],
          ),
        );
      },
    );
  }
}
