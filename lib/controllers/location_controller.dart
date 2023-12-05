import 'package:food_delivery/data/repository/location_repo.dart';
import 'package:get/get.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  
}