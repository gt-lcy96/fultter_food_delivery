import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery/common/values/dimensions.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(10.w),
      alignment: Alignment.topCenter,
      child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: SizedBox(
            width: Dimensions.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      autofocus: true,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        hintText: "search location",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                          borderSide: const BorderSide(
                            style: BorderStyle.none, 
                            width: 0,
                          )
                        ),
                        hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                                color: Theme.of(context).disabledColor,
                                fontSize: 20
                                .sp,
                              )
                      )
                    ),
                    onSuggestionSelected: (Prediction suggestion) {
                      Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController); 
                      Get.back();
                    },
                    suggestionsCallback: (String pattern) async { //as we type, it gives us suggestion
                      return await Get.find<LocationController>().searchLocation(context, pattern);
                    },
                    itemBuilder: (BuildContext context, Prediction suggestion) {
                      return Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            Expanded(child: Text(
                              suggestion.description!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline2?.copyWith(
                                color: Theme.of(context).textTheme.bodyText1?.color,
                                fontSize: 16.sp,
                              )
                              // "Testing"
                            ))
                          ],
                                  
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
