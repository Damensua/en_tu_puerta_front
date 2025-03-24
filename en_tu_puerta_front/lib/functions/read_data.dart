import 'package:en_tu_puerta_front/models/provider.dart';
import 'package:en_tu_puerta_front/models/service.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';

String? token=globalClientToken;

List<Service> parseServices(json) {
  final List<dynamic> data = json['data'];
  return data.map((serviceJson) => Service.fromJson(serviceJson)).toList();
}

List<Provider> parseProviders(json) {
  final List<dynamic> data = json['data'];
  return data.map((providerJson) => Provider.fromJson(providerJson)).toList();
}