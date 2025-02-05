import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_cat_api_duvan/global/models/breed.dart';

class CatBreedService {
  Future<List<Breed>> fetchCatBreeds() async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/breeds'),
    );

    if (response.statusCode == 200) {
      // Decodificamos el cuerpo de la respuesta (String) en un objeto JSON
      final List<dynamic> breedsJson = json.decode(response.body);

      return breedsJson
          .map((jsonBreed) => Breed.fromJsonMap(jsonBreed))
          .toList();
    } else {
      throw Exception('Error al cargar las razas de gatos');
    }
  }
}
