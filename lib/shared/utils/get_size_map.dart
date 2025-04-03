import 'package:flutter/material.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';
import 'package:lyvepulse_components/utils/device_type_utils.dart';
double? getSizeMap(
  BuildContext context,
    // double? xtrasmallPhoneSize,
  double? smallPhoneSize,
  double? smallTabletSize,
  double? largeTabletSize,
  double? smallLaptopSize,
  double? largeLaptopSize,
  double? desktopSize,

) {
  return {
      //  DeviceType.smallMobile: xtrasmallPhoneSize,
    DeviceType.mobile: smallPhoneSize,
    DeviceType.smallTablet: smallTabletSize,
    DeviceType.largeTablet: largeTabletSize,
    DeviceType.smallLaptop: smallLaptopSize,
    DeviceType.largeLaptop: largeLaptopSize,
    DeviceType.desktop: desktopSize,
  }[DeviceTypeUtils.getDeviceType(context)];
}
