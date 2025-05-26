import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final List<String> images = [
    'lib/assets/images/apresentaçao.png',
    'lib/assets/images/apresentaçao2.png',
    'lib/assets/images/apresentaçao3.png',
  ];

  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          items: images
              .map(
                (img) => ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              )
              .toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: 950,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 600),
            autoPlayCurve: Curves.easeInOut,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        // bolinhas indicadoras
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.blue)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
