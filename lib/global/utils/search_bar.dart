import 'package:flutter/material.dart';
import 'package:the_cat_api_duvan/modules/home/screens/search_breeds.dart';

class SearchBarApp extends StatelessWidget {
  final bool isSearchScreen;
  final VoidCallback? onSearchRefresh;
  final String? text;
  final TextEditingController? searchController;

  const SearchBarApp(
      {super.key,
      this.isSearchScreen = false,
      this.onSearchRefresh,
      this.text,
      this.searchController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        searchController ?? TextEditingController(text: text);

    return Container(
        padding: const EdgeInsets.all(15),
        height: 80,
        child: TextField(
          controller: controller,
          textAlignVertical: TextAlignVertical.top,
          onSubmitted: (text) {
            if (isSearchScreen && onSearchRefresh != null) {
              // If already in search screen, refresh
              onSearchRefresh!();
            } else {
              // Navigate to search screen
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SearchBreedsScreen(searchText: controller.text)),
              );
            }
          },
          decoration: const InputDecoration(
            hintText: "Búsqueda",
            hintStyle: TextStyle(
              fontSize: 14,
            ),
            prefixIcon: Icon(Icons.search),
          ),
        ));
  }
}
