import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/widgets/custom_button.dart';
import 'package:food_delivery/controllers/location_controller.dart';
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
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.521563, -122.677433);
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
            body: SafeArea(
          child: Center(
              child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>()
                        .updatePosition(_cameraPosition, false);
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      )
                    ]),
                  ),
                ),
                Positioned(
                  bottom: 200.h,
                  left: 20.w,
                  right: 20.w,
                  child: CustomButton(
                    buttonText: 'Pick Address',
                    onPressed: locationController.loading
                        ? null
                        : () {
                            if (locationController.pickPosition.latitude != 0 &&
                                locationController.pickPlacemark.name != null) {
                              if (widget.fromAddress) {
                                if (widget.googleMapController != null) {
                                  print("Now you can clicked on this");
                                  widget.googleMapController!.moveCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                    target: LatLng(
                                      locationController.pickPosition.latitude,
                                      locationController.pickPosition.longitude,
                                    ),
                                  )));
                                }
                              }
                            }
                          },
                  ),
                )
              ],
            ),
          )),
        ));
      },
    );
  }
}
