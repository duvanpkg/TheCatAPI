import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:the_cat_api_duvan/global/models/breed.dart';
import 'package:the_cat_api_duvan/global/utils/cat_enums.dart';

class BreedDetailsScreen extends StatefulWidget {
  final Breed breed;
  const BreedDetailsScreen({super.key, required this.breed});

  @override
  State<BreedDetailsScreen> createState() => _BreedDetailsScreenState();
}

class _BreedDetailsScreenState extends State<BreedDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.breed.name),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.breed.imageUrl ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error_outline,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.breed.description,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Text.rich(
                          TextSpan(
                            text: 'Origin country: ',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: widget.breed.originCountry,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Intellegence: ',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: Intelligence.values
                                    .firstWhere((e) =>
                                        e.value == widget.breed.intelligence)
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Adaptability: ',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: Adaptability.values
                                    .firstWhere((e) =>
                                        e.value == widget.breed.adaptability)
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Life Span: ',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${widget.breed.lifeSpan} years',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
