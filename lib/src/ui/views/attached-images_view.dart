import 'package:flutter/material.dart';
import 'package:medicine_customer_app/src/ui/views/carousel_view.dart';
import 'package:medicine_customer_app/src/utility/navigator.dart';

class AttachedImagesView extends StatelessWidget {
  final List<String> imagesUrl;

  AttachedImagesView({Key key, @required this.imagesUrl});

  @override
  Widget build(BuildContext context) {
    if (imagesUrl?.isEmpty ?? false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.image),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
          ),
          Text(
            "No Attached Images!",
            style:
                TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.w400),
          ),
        ],
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigateTo(
                context,
                CarouselView(
                  imageUrls: imagesUrl,
                  currentId: index,
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imagesUrl[index]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          );
        },
        itemCount: imagesUrl.length,
      );
    }
  }
}
