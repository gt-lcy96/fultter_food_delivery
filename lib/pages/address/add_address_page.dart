import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/colors.dart';
import 'package:food_delivery/common/values/constants.dart';
import 'package:food_delivery/common/widgets/app_icons.dart';
import 'package:food_delivery/common/widgets/app_text_field.dart';
import 'package:food_delivery/common/widgets/base_text_widget.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:food_delivery/pages/address/pick_address_map.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/logging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  bool _isGPSLocationFetched = false;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition = AppConstants.MAP_INITIAL_POSITION;
  // const CameraPosition(target: _initialPosition, zoom: 17);
  bool _userMovedMap = false;
  bool _isUserInteraction = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
    // print("Get.find<UserController>().userModel:  ${Get.find<UserController>().userModel}");

    // Delay setting the user interaction flag
    Future.delayed(
        Duration(seconds: AppConstants.ALLOW_USER_SET_MAP_AFTER_SECONDS), () {
      setState(() {
        _isUserInteraction = true;
      });
    });
  }

  void _initializeMap() async {
    Get.find<LocationController>().requestPermissions();
    LatLng initialPos = await _getCurrentLocation();
    setState(() {
      _initialPosition = initialPos;
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      _isGPSLocationFetched = true;
    });
    loadUserData();
    setText();
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
      return _initialPosition;
    } catch (e) {
      // Handle exception
      print("--------------------------------");
      print("Exception: ${e} in add_address_page");
      print("--------------------------------");
      return _initialPosition;
    }
  }

  Future<void> loadUserData() async {
    UserController userController = Get.find<UserController>();
    try {
      // await userController.getUserInfo();
      _isLogged = Get.find<AuthController>().userLoggedIn();
      if (_isLogged && userController.userModel == null) {
        await userController.getUserInfo();
      }
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        await Get.find<UserController>().getUserInfo();
        // new
        Get.find<LocationController>().getUserAddress();
        if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
            "") {
          Get.find<LocationController>()
              .saveUserAddress(Get.find<LocationController>().addressList.last);
        }
        // end new

        _cameraPosition = CameraPosition(
            target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]),
        ));

        _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]),
        );
      }
      // Use userModel for further operations
    } catch (error) {
      // Handle error
      print("Error fetching user info: $error");
    }
  }

  Future<void> setText() async {
    var userController = Get.find<UserController>();
    await userController.getUserInfo();

    if (userController.userModel != null && _contactPersonName.text.isEmpty) {
      // if(_contactPersonName.text.isEmpty) {
      _contactPersonName.text = '${userController.userModel.username}';
      _contactPersonNumber.text = '${userController.userModel.phone}';
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _addressController.text =
            Get.find<LocationController>().getUserAddress().address;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address page"),
        backgroundColor: AppColors.primaryElement,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed(RouteHelper.getAccount());
          },
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        print('Get Builder<UserController> is get trigged');
        return GetBuilder<LocationController>(
          builder: (locationController) {
            _addressController.text =
                '${locationController.placemark.name ?? ""}'
                '${locationController.placemark.locality ?? ""}'
                '${locationController.placemark.postalCode ?? ""}'
                '${locationController.placemark.country ?? ""}';
            print("address in my view is " + _addressController.text);

            return (_isGPSLocationFetched || _isUserInteraction)
                ? SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 140.h,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(
                                left: 5.w, right: 5.w, top: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  width: 2.w,
                                  color: AppColors.primaryElement,
                                )),
                            child: Stack(children: [
                              GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target: _initialPosition, zoom: 17),
                                  onTap: (latlng) {
                                    Get.toNamed(
                                        RouteHelper.getPickAddressPage(),
                                        arguments: PickAddressMap(
                                          fromSignUp: false,
                                          fromAddress: true,
                                          googleMapController:
                                              locationController.mapController,
                                        ));
                                  },
                                  zoomControlsEnabled: false,
                                  compassEnabled: false,
                                  indoorViewEnabled: true,
                                  mapToolbarEnabled: false,
                                  myLocationEnabled: true,
                                  onCameraIdle: () {
                                    if (_isUserInteraction) {
                                      locationController.updatePosition(
                                          _cameraPosition, true);
                                    }
                                  },
                                  onCameraMove: ((position) {
                                    _cameraPosition = position;
                                  }),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    locationController
                                        .setMapController(controller);
                                  }),
                            ]),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, top: 20.h),
                            child: SizedBox(
                              height: 50.h,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      locationController.addressTypeList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        locationController
                                            .setAddressTypeIndex(index);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w, vertical: 10.h),
                                          margin: EdgeInsets.only(right: 10.w),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              color:
                                                  Theme.of(context).cardColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[200]!,
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                )
                                              ]),
                                          child: Icon(
                                            index == 0
                                                ? Icons.home_filled
                                                : index == 1
                                                    ? Icons.work
                                                    : Icons.location_on,
                                            color: locationController
                                                        .addressTypeIndex ==
                                                    index
                                                ? AppColors.primaryElement
                                                : Theme.of(context)
                                                    .disabledColor,
                                          )),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: bigText("Delivery address"),
                          ),
                          SizedBox(height: 10.h),
                          AppTextField(
                              textController: _addressController,
                              hintText: "Your address",
                              icon: Icons.map),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: bigText("Contact name"),
                          ),
                          SizedBox(height: 10.h),
                          AppTextField(
                              textController: _contactPersonName,
                              hintText: "Your name",
                              icon: Icons.person),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: bigText("Your number"),
                          ),
                          SizedBox(height: 10.h),
                          AppTextField(
                              textController: _contactPersonNumber,
                              hintText: "Your Phone",
                              icon: Icons.phone),
                        ]),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        );
      }),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100.h,
                padding: EdgeInsets.only(
                    top: 15.h, bottom: 15.h, left: 20.w, right: 20.w),
                decoration: BoxDecoration(
                    color:
                        AppColors.primarySecondaryElementText.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.w * 2),
                      topRight: Radius.circular(20.w * 2),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[
                              locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude:
                              locationController.position.latitude.toString(),
                          longitude:
                              locationController.position.longitude.toString(),
                        );
                        locationController
                            .addAddress(_addressModel)
                            .then((response) {
                          print(response.isSuccess);
                          if (response.isSuccess) {
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar("Address", "Added Successfully");
                          } else {
                            Get.snackbar("Address", "Couldn't save address");
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.w),
                          color: AppColors.primaryElement,
                        ),
                        child: bigText("Save Info",
                            color: Colors.white, fontSize: 26),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
