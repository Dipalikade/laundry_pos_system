import 'package:flutter/material.dart';
import 'package:laundry_pos_system_app/model/category_model.dart';


class CategoryChip extends StatelessWidget {
  final ServiceCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  Color _getColorFromCode(String colorCode) {
    // Map color codes to actual colors
    switch (colorCode) {
      case 'bg-primary':
        return const Color(0xFF2F66C8);
      case 'bg-danger':
        return Colors.red;
      case 'bg-warning':
        return Colors.orange;
      case 'bg-secondary':
        return Colors.grey;
      case 'cheese':
        return Colors.amber;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getColorFromCode(category.colorCode);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? categoryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? categoryColor : categoryColor.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Text(
          category.name,
          style: TextStyle(
            color: isSelected ? Colors.white : categoryColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}