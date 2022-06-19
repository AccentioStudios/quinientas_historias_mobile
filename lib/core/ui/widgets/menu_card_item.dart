import 'package:flutter/material.dart';

import '../../../data/entities/product_entity.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class MenuCardItem extends StatelessWidget {
  const MenuCardItem({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);
  final ProductEntity product;
  final void Function(ProductEntity product) onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(product);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: primary95Color,
          borderRadius: Constants.borderRadius16,
        ),
        height: 145,
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 38,
                    child: Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 46,
                    child: Text(
                      product.desc,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                        height: 1.3,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.price.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 103,
              height: 103,
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: Constants.borderRadius16,
                child: Hero(
                  tag: 'product-${product.id}',
                  child: Image.network(
                    product.imgPath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
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
            ),
          ],
        ),
      ),
    );
  }
}
