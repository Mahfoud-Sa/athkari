import 'package:athkari/app/features/daily_wered/domain/entities/dhkar.dart';

class DhkarModel extends DhkarEntity {
  DhkarModel({
    int? id,
    String? dhkar,
    int? no_of_repeating,
  });

  // ignore: avoid_types_as_parameter_names
  factory DhkarModel.fromJson(Map<String, dynamic> json) {
    return DhkarModel();
  }
}
