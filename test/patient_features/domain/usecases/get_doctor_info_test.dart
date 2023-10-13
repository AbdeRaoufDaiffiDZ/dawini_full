// // ignore_for_file: unused_local_variable

// import 'package:dartz/dartz.dart';
// import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
// import 'package:dawini_full/patient_features/domain/usecases/get_doctors_info.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import '../../helpers/test_helper.mocks.dart';

// void main() {
//   GetDoctorsInfoUseCase? getDoctorsInfoUseCase;
//   MockDoctorRepository? mockDoctorRepository;

//   setUp(() {
//     mockDoctorRepository = MockDoctorRepository();
//     getDoctorsInfoUseCase =
//         GetDoctorsInfoUseCase(doctorRepository: mockDoctorRepository!);
//   });

//   var testDoctorEntityDetails = DoctorEntity(
//       firstName: 'Dawini', lastName: 'App', phoneNumber: '0674282928');

//   test("should get a doctor info from repository ", () async {
//     // arrange
//     when(mockDoctorRepository?.getDoctorsInfo())
//         .thenAnswer((realInvocation) async => Right(testDoctorEntityDetails));
//     // act
//     final result = await getDoctorsInfoUseCase?.excute();
//     // assert
//     expect(result, Right(testDoctorEntityDetails));
//   });
// }
