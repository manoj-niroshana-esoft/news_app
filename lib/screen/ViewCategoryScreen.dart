import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../helper/DatabaseHelper.dart';

class ViewCategoryScreen extends StatefulWidget {
  const ViewCategoryScreen({super.key});

  @override
  _ViewCategoryScreenState createState() => _ViewCategoryScreenState();
}

class _ViewCategoryScreenState extends State<ViewCategoryScreen> {
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> categories = await db.query('categories');
    setState(() {
      _categories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Categories'),
      ),
      body: _categories.isEmpty
          ? const Center(
              child: Text('No categories available.'),
            )
          : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(_categories[index]);
              },
            ),
    );
  }

  Widget _buildCategoryCard(Map<String, dynamic> category) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category Name: ${category['name']}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category Description: ${category['description']}',
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        onTap: () {
          // Handle category selection
          // You can navigate to a details screen or perform other actions
        },
      ),
    );
  }

}
