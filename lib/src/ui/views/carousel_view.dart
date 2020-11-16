import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CarouselView extends StatelessWidget {
  final int currentId;
  final List<dynamic> imageUrls;

  CarouselView({Key key, @required this.imageUrls, this.currentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: PageController(
              initialPage: currentId, keepPage: true, viewportFraction: 1),
          itemCount: imageUrls.length,
          itemBuilder: (context, i) {
            return InteractiveViewer(
                child: Center(
                    child: Image.network(
              '${imageUrls[i]}',
              fit: BoxFit.fill,
            )));
          }),
    );
  }
}
