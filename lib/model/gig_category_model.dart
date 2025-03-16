class GigCategoryModel {
  String categoryId;
  String categoryName;
  String categoryIcon;

  GigCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryIcon,
  });

  factory GigCategoryModel.fromMap(Map<String, dynamic> map) {
    return GigCategoryModel(
      categoryId: map['categoryId'] ?? '',
      categoryName: map['categoryName'] ?? '',
      categoryIcon: map['categoryIcon'] ?? '',
    );
  }
}
