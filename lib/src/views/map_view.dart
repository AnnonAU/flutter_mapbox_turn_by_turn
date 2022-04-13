import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:device_info_plus/device_info_plus.dart';

int sdkVersion = 0;

// The widget that show the mapbox MapView
class MapView extends StatelessWidget {
  MapView({
    Key? key,
    this.zoom,
    this.pitch,
    this.mapStyleUrlDay,
    this.mapStyleUrlNight,
    this.navigateOnLongClick,
    this.routeCasingColor,
    this.routeDefaultColor,
    this.restrictedRoadColor,
    this.routeLineTraveledColor,
    this.routeLineTraveledCasingColor,
    this.routeClosureColor,
    this.routeLowCongestionColor,
    this.routeModerateCongestionColor,
    this.routeHeavyCongestionColor,
    this.routeSevereCongestionColor,
    this.routeUnknownCongestionColor,
  }) : super(key: key) {
    getSdkVersion();
  }

  getSdkVersion() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      sdkVersion = androidInfo.version.sdkInt!;
    } else {
      sdkVersion = -1;
    }
  }

  final double? zoom;
  final double? pitch;
  final String? mapStyleUrlDay;
  final String? mapStyleUrlNight;
  final bool? navigateOnLongClick;
  final Color? routeCasingColor;
  final Color? routeDefaultColor;
  final Color? restrictedRoadColor;
  final Color? routeLineTraveledColor;
  final Color? routeLineTraveledCasingColor;
  final Color? routeClosureColor;
  final Color? routeLowCongestionColor;
  final Color? routeModerateCongestionColor;
  final Color? routeHeavyCongestionColor;
  final Color? routeSevereCongestionColor;
  final Color? routeUnknownCongestionColor;

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'MapView';

    String routeCasingColorString = "#0066ff";
    if (routeCasingColor != null) {
      routeCasingColorString = "#${routeCasingColor?.value.toRadixString(16)}";
    }

    String routeDefaultColorString = "#0066ff";
    if (routeDefaultColor != null) {
      routeDefaultColorString =
          "#${routeDefaultColor?.value.toRadixString(16)}";
    }

    String restrictedRoadColorString = "#737373";
    if (restrictedRoadColor != null) {
      restrictedRoadColorString =
          "#${restrictedRoadColor?.value.toRadixString(16)}";
    }

    String routeLineTraveledColorString = "#b3b3b3";
    if (routeLineTraveledColor != null) {
      routeLineTraveledColorString =
          "#${routeLineTraveledColor?.value.toRadixString(16)}";
    }

    String routeLineTraveledCasingColorString = "#b3b3b3";
    if (routeLineTraveledCasingColor != null) {
      routeLineTraveledCasingColorString =
          "#${routeLineTraveledCasingColor?.value.toRadixString(16)}";
    }

    String routeClosureColorString = "#4a4a4a";
    if (routeClosureColor != null) {
      routeClosureColorString =
          "#${routeClosureColor?.value.toRadixString(16)}";
    }

    String routeLowCongestionColorString = "#0066ff";
    if (routeLowCongestionColor != null) {
      routeLowCongestionColorString =
          "#${routeLowCongestionColor?.value.toRadixString(16)}";
    }

    String routeModerateCongestionColorString = "#ffc400";
    if (routeModerateCongestionColor != null) {
      routeModerateCongestionColorString =
          "#${routeModerateCongestionColor?.value.toRadixString(16)}";
    }

    String routeHeavyCongestionColorString = "#ff8000";
    if (routeHeavyCongestionColor != null) {
      routeHeavyCongestionColorString =
          "#${routeHeavyCongestionColor?.value.toRadixString(16)}";
    }

    String routeSevereCongestionColorString = "#ff0000";
    if (routeSevereCongestionColor != null) {
      routeSevereCongestionColorString =
          "#${routeSevereCongestionColor?.value.toRadixString(16)}";
    }

    String routeUnknownCongestionColorString = "#0066ff";
    if (routeUnknownCongestionColor != null) {
      routeUnknownCongestionColorString =
          "#${routeUnknownCongestionColor?.value.toRadixString(16)}";
    }

    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{
      "zoom": zoom,
      "pitch": pitch,
      "mapStyleUrlDay": mapStyleUrlDay,
      "mapStyleUrlNight": mapStyleUrlNight,
      "navigateOnLongClick": navigateOnLongClick,
      "routeCasingColor": routeCasingColorString,
      "routeDefaultColor": routeDefaultColorString,
      "restrictedRoadColor": restrictedRoadColorString,
      "routeLineTraveledColor": routeLineTraveledColorString,
      "routeLineTraveledCasingColor": routeLineTraveledCasingColorString,
      "routeClosureColor": routeClosureColorString,
      "routeLowCongestionColor": routeLowCongestionColorString,
      "routeModerateCongestionColor": routeModerateCongestionColorString,
      "routeHeavyCongestionColor": routeHeavyCongestionColorString,
      "routeSevereCongestionColor": routeSevereCongestionColorString,
      "routeUnknownCongestionColor": routeUnknownCongestionColorString,
    };

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        if (sdkVersion < 29) {
          debugPrint("Android SDK is less than 29. Using virtual display.");
          return AndroidView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
          );
        }

        debugPrint("Android SDK is greater than 28. Using hybrid composition.");
        return PlatformViewLink(
          viewType: viewType,
          surfaceFactory:
              (BuildContext context, PlatformViewController controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <
                  Factory<OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (PlatformViewCreationParams params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        );
      case TargetPlatform.iOS:
        return UiKitView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec());
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
}
