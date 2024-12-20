import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/data/repositories/doctor_repository_impl.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/domain/repositories/doctor_repository.dart';

class GetDoctorsInfoUseCase {
  final DoctorRepository doctorRepository;

  GetDoctorsInfoUseCase({required this.doctorRepository});

  Future<List<DoctorEntity>> excute() async {
    Either<Failure, List<DoctorEntity>> info;
    info = await doctorRepository.getDoctorsInfo();

    return info.fold(
        (l) => throw (ServerFailure(message: l.message)), (r) => r);
  }
}

class GetDoctorsStreamInfoUseCase {
  static final DoctorRepository doctorRepository = DcotrRepositoryImpl();

  static Stream<List<DoctorEntity>> excute() {
    return doctorRepository.streamDoctors();
  }
}

class BookDoctorAppointmentUseCase {
  static final DoctorRepository doctorRepository = DcotrRepositoryImpl();

  Future<bool> excute(PatientEntity patientEntity) {
    return doctorRepository.SetDoctorAppointmentOnline(patientEntity);
  }
}

class DeleteDoctorAppointmentUseCase {
  static final DoctorRepository doctorRepository = DcotrRepositoryImpl();

  Future<bool> excute(PatientEntity patientEntity) {
    return doctorRepository.DeleteDoctorAppointmentOnline(patientEntity);
  }
}
