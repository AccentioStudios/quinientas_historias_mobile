import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class Constants {
  static double get wideScrenSize => 1500;
  static BorderRadius get borderRadius9 => BorderRadius.circular(9.0);
  static BorderRadius get borderRadius16 => BorderRadius.circular(16.0);
  static BorderRadius get borderRadius18 => BorderRadius.circular(18.0);
  static BorderRadius get borderRadius23 => BorderRadius.circular(23.0);
  static BorderRadius get borderRadius50 => BorderRadius.circular(50.0);
  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space18 = 18;
  static const double space21 = 21;
  static const double space30 = 30;
  static const double space41 = 41;

  static WebUiSettings getWebUiSettings(BuildContext context) => WebUiSettings(
        context: context,
        enableZoom: true,
        enableResize: true,
        mouseWheelZoom: true,
        boundary: CroppieBoundary(
          width: MediaQuery.sizeOf(context).width.toInt() - 150,
          height: MediaQuery.sizeOf(context).width.toInt() - 150,
        ),
        viewPort: CroppieViewPort(
          width: MediaQuery.sizeOf(context).width.toInt() - 160,
          height: MediaQuery.sizeOf(context).width.toInt() - 160,
        ),
      );
}

class FeatureFlag {
  static bool aliceEnabled = kDebugMode;
}
