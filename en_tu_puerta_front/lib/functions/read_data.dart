

import 'package:en_tu_puerta_front/models/service.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';

String? token=globalToken;

List<Service> parseServices(json) {
  final List<dynamic> data = json['data'];
  return data.map((serviceJson) => Service.fromJson(serviceJson)).toList();
}