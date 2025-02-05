import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_cat_api_duvan/global/models/breed.dart';
import 'package:the_cat_api_duvan/global/utils/cat_enums.dart';

class BreedCard extends StatelessWidget {
  final Breed breed;

  const BreedCard({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  breed.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 26,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8)),
                child: CachedNetworkImage(
                    imageUrl: breed.imageUrl ??
                        'https://www.iconpacks.net/icons/4/free-no-image-icon-14596-thumb.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Origin: ${breed.originCountry}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                  'Intelligence: ${Intelligence.values.firstWhere((e) => e.value == breed.intelligence)}',
                  style: const TextStyle(
                    fontSize: 14,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
