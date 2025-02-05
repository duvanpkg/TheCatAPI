import 'package:flutter/material.dart';
import 'package:the_cat_api_duvan/global/models/breed.dart';
import 'package:the_cat_api_duvan/global/services/cat_breed.dart';
import 'package:the_cat_api_duvan/global/widgets/search_bar.dart';
import 'package:the_cat_api_duvan/modules/home/screens/breed_details.dart';
import 'package:the_cat_api_duvan/modules/home/widgets/breed_card.dart';

class SearchBreedsScreen extends StatefulWidget {
  final String searchText;
  const SearchBreedsScreen({super.key, required this.searchText});

  @override
  State<SearchBreedsScreen> createState() => _SearchBreedsScreenState();
}

class _SearchBreedsScreenState extends State<SearchBreedsScreen> {
  List<Breed> breeds = [];
  late final TextEditingController _searchController =
      TextEditingController(text: widget.searchText);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchBreeds(widget.searchText);
  }

  Future<void> _searchBreeds(String searchText) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await CatBreedService().searchPosts(searchText);
      setState(() {
        breeds = results;
      });
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarApp(
                searchController: _searchController,
                text: widget.searchText,
                isSearchScreen: true,
                onSearchRefresh: () {
                  // Llamar a la búsqueda cuando el usuario realice una nueva búsqueda
                  _searchBreeds(_searchController.text);
                },
              ),
              if (_isLoading) const Center(child: CircularProgressIndicator()),
              if (!_isLoading && breeds.isEmpty)
                const Center(child: Text("No se han encontrado publicaciones")),
              if (!_isLoading && breeds.isNotEmpty)
                Center(
                  child:
                      Text("Se han encontrado ${breeds.length} publicaciones"),
                ),
              const SizedBox(height: 20),
              if (!_isLoading)
                Expanded(
                  child: ListView.builder(
                    itemCount: breeds.length,
                    itemBuilder: (context, index) {
                      final breed = breeds[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BreedDetailsScreen(breed: breed),
                              ),
                            );
                          },
                          child: BreedCard(breed: breed));
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
