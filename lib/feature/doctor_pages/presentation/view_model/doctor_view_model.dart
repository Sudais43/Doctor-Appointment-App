import 'package:flutter/material.dart';
import 'package:skin_firts/feature/doctor_pages/presentation/pages/doctor_detail.dart';
import 'package:skin_firts/feature/homePage/data/home_page_data.dart';
import 'package:skin_firts/feature/homePage/domain/entities/doctor_info.dart';

class DoctorViewModel extends ChangeNotifier {
  //Move To Doctor Detail page
  void moveToDoctorDetail(BuildContext context, DoctorInfo doc ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => DoctorDetail(
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
