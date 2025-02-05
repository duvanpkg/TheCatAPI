import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_cat_api_duvan/global/models/breed.dart';

class CatBreedService {
  Future<List<Breed>> fetchCatBreeds(
      {required int page, required int limit}) async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/breeds?limit=$limit&page=$page'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> breedsJson = json.decode(response.body);
      final List<Breed> breeds = [];

      for (var jsonBreed in breedsJson) {
        final breed = Breed.fromJsonMap(jsonBreed);

        if (breed.imageReferenceId != null) {
          final imageResponse = await http.get(
            Uri.parse(
                'https://api.thecatapi.com/v1/images/${breed.imageReferenceId}'),
          );

          if (imageResponse.statusCode == 200) {
            final imageJson = json.decode(imageResponse.body);
            breed.imageUrl = imageJson['url'];
          } else {
            breed.imageUrl =
                'https://www.iconpacks.net/icons/4/free-no-image-icon-14596-thumb.png'; // fallback if image fetch fails
          }
        } else {
          breed.imageUrl =
              'https://www.iconpacks.net/icons/4/free-no-image-icon-14596-thumb.png'; // some breeds don't have an image
        }

        breeds.add(breed);
      }

      return breeds;
    } else {
      throw Exception('Error al cargar las razas de gatos');
    }
  }
}
