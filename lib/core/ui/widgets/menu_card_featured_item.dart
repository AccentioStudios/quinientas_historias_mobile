import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class MenuCardFeaturedItem extends StatelessWidget {
  const MenuCardFeaturedItem({
    Key? key,
    required this.title,
    required this.desc,
    required this.price,
    required this.imgPath,
  }) : super(key: key);

  final String title;
  final String desc;
  final String price;
  final String imgPath;
  @override
  Widget build(BuildContext context) {
    var widthFactor = 0.85;
    const textShadows = [
      Shadow(
        offset: Offset(0, 4.0),
        blurRadius: 8.0,
        color: Color.fromRGBO(0, 0, 0, 0.5),
      )
    ];
    return Container(
      width: double.infinity,
      height: 151,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: primaryContainerColor,
        borderRadius: Constants.borderRadius16,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            right: 12,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              width: 32,
              height: 32,
              child: const Icon(
                Icons.add,
                color: primaryColor,
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: widthFactor,
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: Constants.borderRadius16,
              child: Image.network(
                imgPath,
                fit: BoxFit.cover,
                width: double.infinity,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: widthFactor,
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: Constants.borderRadius16,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(69, 58, 18, 18),
                      Color.fromARGB(185, 58, 18, 18)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: widthFactor,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 38,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        shadows: textShadows,
                        color: Colors.white,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 46,
                    child: Text(
                      desc,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        shadows: textShadows,
                        height: 1.3,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      shadows: textShadows,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
