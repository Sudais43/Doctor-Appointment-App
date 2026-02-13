import 'package:flutter/material.dart';
import 'package:skin_firts/core/navigation/page_transition.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/pages/doctor_detail.dart';
import 'package:skin_firts/feature/homePage/domain/entities/doctor_info.dart';

class DoctorViewModel extends ChangeNotifier {
  String? _expandedDoctorName;
  String? get expandedDoctorName => _expandedDoctorName;

  void toggleExpansion(String doctorName) {
    if (_expandedDoctorName == doctorName) {
      _expandedDoctorName = null;
    }else{
      _expandedDoctorName = doctorName;
    }
    notifyListeners();
  }

  //Move To Doctor Detail page
  void moveToDoctorDetail(BuildContext context, DoctorInfo doc) {
    Navigator.push(
      context,
      FadeRoute(
        page: DoctorDetail(
          doctorName: doc.name,
          image: doc.images,
          speciality: doc.Department,
          isFavorite: doc.isFavorite,
        ),
      ),
    );
  }

  void moveToPreviousPage(BuildContext context) {
    Navigator.pop(context);
  }
}
