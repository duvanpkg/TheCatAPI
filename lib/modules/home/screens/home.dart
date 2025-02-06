import 'package:flutter/material.dart';
import 'package:the_cat_api_duvan/config/theme/app_theme.dart';
import 'package:the_cat_api_duvan/global/models/breed.dart';
import 'package:the_cat_api_duvan/global/services/cat_breed.dart';
import 'package:the_cat_api_duvan/global/widgets/search_bar.dart';
import 'package:the_cat_api_duvan/modules/home/screens/breed_details.dart';
import 'package:the_cat_api_duvan/modules/home/widgets/breed_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  final List<Breed> _allBreeds = [];
  int _currentPage = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _loadBreeds();

    // Detect when we reach the bottom of the list to load more breeds
    _scrollController.addListener(() {
      // Start loading more breeds when the user is close to the bottom of the list
      if (_scrollController.position.pixels >
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading) {
        _loadBreeds();
      }
    });
  }

  Future<void> _loadBreeds() async {
    // this prevents multiple simultaneous fetch requests
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      List<Breed> newBreeds =
          await CatBreedService().fetchCatBreeds(page: _currentPage, limit: 10);
      setState(() {
        _allBreeds.addAll(newBreeds);
        _currentPage++;
      });
    } catch (e) {
      print('Something went wrong: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cat's breeds"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SearchBarApp(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _allBreeds.length +
                    (_isLoading
                        ? 1
                        : 0), // Extra item for the loading indicator
                itemBuilder: (context, index) {
                  if (index == _allBreeds.length) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // show loading indicator in the end
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BreedDetailsScreen(breed: _allBreeds[index]),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BreedCard(breed: _allBreeds[index]),
                        if (index != _allBreeds.length - 1)
                          const Divider(color: greyLight, thickness: 0.5),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
