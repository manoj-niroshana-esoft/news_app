// AddCategoryScreen.dart

import 'package:flutter/material.dart';

import '../helper/DatabaseHelper.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});
  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _categoryNameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                hintText: 'Enter category name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _categoryDescriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Category Description',
                hintText: 'Enter category description',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _addCategory();
              },
              child: const Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }

  void _addCategory() async {
    String categoryName = _categoryNameController.text.trim();
    String categoryDescription = _categoryDescriptionController.text.trim();

    if (categoryName.isNotEmpty && categoryDescription.isNotEmpty) {
      Map<String, dynamic> category = {
        'name': categoryName,
        'description': categoryDescription,
      };

      int categoryId = await DatabaseHelper.instance.insertCategory(category);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Category added successfully with ID: $categoryId'),
        ),
      );

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Both category name and description are mandatory'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
