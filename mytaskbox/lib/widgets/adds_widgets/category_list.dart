import 'package:flutter/material.dart';
import 'package:mytaskbox/color/colors_const.dart';

final List<Map<String, dynamic>> categories = [
  {'name': 'Work', 'icon': Icons.work},
  {'name': 'School', 'icon': Icons.school},
  {'name': 'Fitness', 'icon': Icons.fitness_center},
  {'name': 'Shopping', 'icon': Icons.shopping_cart},
  {'name': 'Home', 'icon': Icons.home_filled},
];

class CategoryList extends StatefulWidget {
  const CategoryList({
    super.key,
    required this.onCategorySelected,
    this.selectedCategory,
  });

  final void Function(String selectedCategory)? onCategorySelected;
  final String? selectedCategory;

  static List<String> get allCategoryNames =>
      categories.map((c) => c['name'] as String).toList();

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int? _isSelectedCategory;

  @override
  void initState() {
    super.initState();
    final initialIndex = categories.indexWhere(
      (cat) => cat['name'].toString().toLowerCase() ==
          widget.selectedCategory?.toLowerCase(),
    );
    if (initialIndex != -1) {
      _isSelectedCategory = initialIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  final category = categories[index];
                  final isSelected = _isSelectedCategory == index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSelectedCategory = index;
                        });
                        if (widget.onCategorySelected != null) {
                          widget.onCategorySelected!(category['name']);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? iconFocus
                              : const Color.fromARGB(255, 101, 183, 251),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              category['icon'],
                              size: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              category['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
