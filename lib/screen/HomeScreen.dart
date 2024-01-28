import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screen/ViewDetailsSccreen.dart';

import '../Provider/NewsProvider.dart';
import 'AddCategoryScreen.dart';
import 'ViewCategoryScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    Provider.of<NewsProvider>(context, listen: false).fetchNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('News'), // Set the title of the app bar
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Provider.of<NewsProvider>(context, listen: false)
                  .filterNews(_searchController.text);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: w * 0.3,
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search News',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              _showSortDialog(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<NewsProvider>(
          builder: (context, newsProvider, child) {
            if (newsProvider.news == null) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Fetching data...'),
                ],
              );
            } else if (newsProvider.filteredNews.isEmpty &&
                newsProvider.news == null) {
              return const Center(
                child: Text('No news available.'),
              );
            } else if (newsProvider.filteredNews.isEmpty &&
                newsProvider.news != null) {
              return ListView.builder(
                  itemCount: newsProvider.news?.data.length,
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewDetailsScreen(
                                  news: newsProvider.news?.data
                                      .elementAt(index))),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: w,
                          height: 100.0,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(newsProvider.news?.data
                                        .elementAt(index)
                                        .urlToImage ??
                                    "https://advisorretire.com/wp-content/plugins/pl-platform/engine/ui/images/default-landscape.png"),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${newsProvider.news?.data.elementAt(index).title} "),
                                      const SizedBox(
                                          // height: 20.0,
                                          ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else if (newsProvider.filteredNews.isNotEmpty &&
                newsProvider.news != null) {
              return ListView.builder(
                  itemCount: newsProvider.filteredNews.length,
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewDetailsScreen(
                                  news: newsProvider.filteredNews
                                      .elementAt(index))),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: w,
                          height: 100.0,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(newsProvider.filteredNews
                                        .elementAt(index)
                                        .urlToImage ??
                                    "https://advisorretire.com/wp-content/plugins/pl-platform/engine/ui/images/default-landscape.png"),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${newsProvider.filteredNews.elementAt(index).title} "),
                                      const SizedBox(
                                          // height: 20.0,
                                          ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return ListView.builder(
                  itemCount: newsProvider.news?.data.length,
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewDetailsScreen(
                                  news: newsProvider.news?.data
                                      .elementAt(index))),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: w,
                          height: 100.0,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(newsProvider.news?.data
                                        .elementAt(index)
                                        .urlToImage ??
                                    "https://advisorretire.com/wp-content/plugins/pl-platform/engine/ui/images/default-landscape.png"),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${newsProvider.news?.data.elementAt(index).title} "),
                                      const SizedBox(
                                          // height: 20.0,
                                          ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Handle the logic for adding categories
              _showAddCategoryDialog(context);
            },
            tooltip: 'Add Category',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Handle the logic for viewing categories
              _viewCategories(context);
            },
            tooltip: 'View Categories',
            child: Icon(Icons.list),
          ),
        ],
      ),
    );
  }
}

// Helper method to show sorting options
void _showSortDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sort News By'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Title'),
              onTap: () {
                Provider.of<NewsProvider>(context, listen: false)
                    .sortNewsByTitle();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Date'),
              onTap: () {
                Provider.of<NewsProvider>(context, listen: false)
                    .sortNewsByDate();
                Navigator.of(context).pop();
              },
            ),
            // Add more sorting options as needed
          ],
        ),
      );
    },
  );
}

void _showAddCategoryDialog(BuildContext context) {
  // Implement your logic to add categories here
  // Show a dialog or navigate to another screen for adding categories
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Category'),
        // ... add category form or input fields ...
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
              // Navigate to Add new Category Screen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddCategoryScreen(),
                ),
              );
            },
            child: const Text('Add'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog without adding a category
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
void _viewCategories(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ViewCategoryScreen(),
    ),
  );
}
