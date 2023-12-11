import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/common/widgets/custom_button.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/pages/address/widgets/search_location_dialogue_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {super.key,
      required this.fromSignUp,
      required this.fromAddress,
      this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition = AppConstants.MAP_INITIAL_POSITION;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  bool _isGPSLocationFetched = false;
  bool isFetchLocationTimeOut = false;

  void initState() {
    super.initState();
    _initializeMap();
  }

  void _initializeMap() async {
    Get.find<LocationController>().requestPermissions();
    LatLng initialPos = await _getCurrentLocation();
    setState(() {
      _initialPosition = initialPos;
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      _isGPSLocationFetched = true;
    });
    // setLocationFromStorage();
    // Other setup...
  }

  Future<LatLng> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .timeout(
              const Duration(seconds: AppConstants.GET_GPS_LOCATION_TIMEOUT),
              onTimeout: () {
        throw TimeoutException(
            'Failed to get current location within the time');
      });
      LatLng latlng_position = LatLng(position.latitude, position.longitude);
      return latlng_position;
    } on TimeoutException catch (e) {
      // Handle the timeout exception
      print("--------------------------------");
      print(e);
      print("--------------------------------");
      // Return a default position or handle the situation appropriately
      isFetchLocationTimeOut = true;
      return _initialPosition;
    } catch (e) {
      // Handle exception
      print("--------------------------------");
      print("Exception: ${e} in add_address_page");
      print("--------------------------------");
      return _initialPosition;
    }
  }

  setLocationFromStorage() {
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = AppConstants.MAP_INITIAL_POSITION;
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]),
        );

        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
            body: (_isGPSLocationFetched || isFetchLocationTimeOut)
                ? SafeArea(
                    child: Center(
                        child: SizedBox(
                      width: double.maxFinite,
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            zoomControlsEnabled: false,
                            onCameraMove: (CameraPosition cameraPosition) {
                              _cameraPosition = cameraPosition;
                            },
                            onCameraIdle: () {
                              Get.find<LocationController>()
                                  .updatePosition(_cameraPosition, false);
                            },
                            onMapCreated: (GoogleMapController mapController) {
                              _mapController = mapController;
                              //if(!widget.fromAddress) and other stuff
                            },
                          ),
                          Center(
                              child: !locationController.loading
                                  ? Image.asset(
                                      "assets/images/pick_location.png",
                                      height: 50,
                                      width: 50,
                                    )
                                  : CircularProgressIndicator()),
                          Positioned(
                            top: 45.h,
                            left: 20.w,
                            right: 20.w,
                            child: InkWell(
                              onTap: () => Get.dialog(LocationDialogue(
                                  mapController: _mapController)),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryElement,
                                  borderRadius: BorderRadius.circular(10.w),
                                ),
                                child: Row(children: [
                                  Icon(Icons.location_on,
                                      size: 25, color: AppColors.yellowColor),
                                  Expanded(
                                    child: Text(
                                        '${locationController.pickPlacemark.name ?? ""}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  SizedBox(width: 10.w),
                                  VerticalDivider(
                                    color: Colors.white,
                                    thickness: 2,
                                    indent: 10.h,
                                    endIndent: 10.h,
                                  ),
                                  Icon(Icons.search,
                                      size: 25.w, color: Colors.white),
                                ]),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 80.h,
                            left: 20.w,
                            right: 20.w,
                            child: locationController.isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CustomButton(
                                    buttonText: locationController.inZone
                                        ? widget.fromAddress
                                            ? 'Pick Address'
                                            : 'Pick Location'
                                        : 'Service is not available in your area',
                                    onPressed: (locationController
                                                .buttonDisabled ||
                                            locationController.loading)
                                        ? null
                                        : () {
                                            if (locationController.pickPosition
                                                        .latitude !=
                                                    0 &&
                                                locationController
                                                        .pickPlacemark.name !=
                                                    null) {
                                              if (widget.fromAddress) {
                                                if (widget
                                                        .googleMapController !=
                                                    null) {
                                                  print(
                                                      "Now you can clicked on this");
                                                  widget.googleMapController!
                                                      .moveCamera(CameraUpdate
                                                          .newCameraPosition(
                                                              CameraPosition(
                                                    target: LatLng(
                                                      locationController
                                                          .pickPosition
                                                          .latitude,
                                                      locationController
                                                          .pickPosition
                                                          .longitude,
                                                    ),
                                                  )));
                                                  locationController
                                                      .setAddAddressData();
                                                }
                                                //Get.back() creates update problem
                                                Get.toNamed(RouteHelper
                                                    .getAddressPage());
                                              }
                                            }
                                          },
                                  ),
                          )
                        ],
                      ),
                    )),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ));
      },
    );
  }
}
