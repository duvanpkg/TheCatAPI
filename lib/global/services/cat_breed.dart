import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_cat_api_duvan/global/models/breed.dart';

class CatBreedService {
  Future<List<Breed>> fetchCatBreeds(
      {required int page, required int limit}) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.thecatapi.com/v1/breeds?limit=$limit&page=$page'),
        headers: {
          // this api key is public, it's not a problem to show it, but it's better to hide it in a .env file
          'x-api-key':
              'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> breedsJson = json.decode(response.body);
        final List<Breed> breeds = [];

        for (var jsonBreed in breedsJson) {
          final breed = Breed.fromJsonMap(jsonBreed);

          if (breed.imageUrl == null || breed.imageUrl == '') {
            breed.imageUrl =
                'https://www.iconpacks.net/icons/4/free-no-image-icon-14596-thumb.png'; // some breeds don't have an image
          }
          breeds.add(breed);
        }

        return breeds;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error al cargar las razas de gatos');
    }
  }

  Future<List<Breed>> searchPosts(String searchText) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.thecatapi.com/v1/breeds/search?q=$searchText'),
        headers: {
          'x-api-key':
              'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> breedsJson = json.decode(response.body);
        final List<Breed> breeds = [];

        for (var jsonBreed in breedsJson) {
          final breed = Breed.fromJsonMap(jsonBreed);

          if (breed.imageUrl == null || breed.imageUrl == '') {
            breed.imageUrl =
                'https://www.iconpacks.net/icons/4/free-no-image-icon-14596-thumb.png'; // some breeds don't have an image
          }

          breeds.add(breed);
        }
        return breeds;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error al cargar las razas de gatos');
    }
  }
}
