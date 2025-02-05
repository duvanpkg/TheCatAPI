import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:the_cat_api_duvan/config/theme/app_theme.dart';

class CustomImageViewer extends StatefulWidget {
  /// List of image URLs to show
  final List<String> imgsUrls;

  /// Position of the image to show first
  final int initialPage;

  const CustomImageViewer({
    super.key,
    required this.imgsUrls,
    this.initialPage = 0,
  });

  @override
  State<CustomImageViewer> createState() => _CustomImageViewerState();
}

class _CustomImageViewerState extends State<CustomImageViewer> {
  late final PageController _pageController;

  final ValueNotifier<int> _currentPageNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    // Create the page controller
    _pageController = PageController(initialPage: widget.initialPage);
    // Stablish the initial page
    _currentPageNotifier.value = widget.initialPage;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Image viewer
          PhotoViewGallery.builder(
            itemCount: widget.imgsUrls.length,
            pageController: _pageController,
            onPageChanged: (index) {
              _currentPageNotifier.value = index;
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    CachedNetworkImageProvider(widget.imgsUrls[index]),
                minScale: PhotoViewComputedScale.contained * 1,
                maxScale: PhotoViewComputedScale.covered * 3,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.imgsUrls[index]),
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),

          // Close button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 10,
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.5),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 30, // Smaller circle diameter
                  height: 30, // Smaller circle diameter
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 16, // Smaller icon size
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Dots
          if (widget.imgsUrls.length > 1)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 10,
              left: 0,
              right: 0,
              child: ValueListenableBuilder<int>(
                valueListenable: _currentPageNotifier,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.imgsUrls.length,
                      (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: value == index ? primaryColor : Colors.grey,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
