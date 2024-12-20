import 'package:dartz/dartz.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:dawini_full/patient_features/data/repositories/clinic_repository_impl.dart';
import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/domain/repositories/clinic_repository.dart';

class GetClinicsInfoUseCase {
  final ClinicRepository clinicRepository;

  GetClinicsInfoUseCase({required this.clinicRepository});

  Future<List<ClinicEntity>> excute() async {
    Either<Failure, List<ClinicEntity>> info;
    info = await clinicRepository.getClincsInfo();

    return info.fold(
        (l) => throw (ServerFailure(message: l.message)), (r) => r);
  }
}

class GetClinicsStreamInfoUseCase {
  static final ClinicRepository clinicRepository = ClinicRepositoryImpl();

  static Stream<List<ClinicEntity>> excute() {
    return clinicRepository.streamClincss();
  }
}
