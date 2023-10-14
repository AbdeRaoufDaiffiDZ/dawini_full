// ignore_for_file: prefer_const_constructors

import 'package:dawini_full/core/constants/constants.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/presentation/bloc/auth_bloc/bloc/doctor_auth_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/weather_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/weather_event.dart';
import 'package:dawini_full/patient_features/presentation/bloc/weather_state.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "WEATHER",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                fillColor: const Color(0xffF3F3F3),
                filled: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) {
                context.read<WeatherBloc>().add(onCityChanged(cityName: value));
              },
            ),
            SizedBox(
              height: 32.0,
            ),
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
              if (state is WeatherLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is WeatherLoaded) {
                return Column(
                  key: const Key('weather_data'),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.result.cityName,
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${state.result.main} | ${state.result.description}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Table(
                      defaultColumnWidth: const FixedColumnWidth(150.0),
                      border: TableBorder.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      children: [
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Temperature',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.result.temperature.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ), // Will be change later
                        ]),
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Pressure',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.result.pressure.toString(),
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ), // Will be change later
                        ]),
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Humidity',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.result.humidity.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ), // Will be change later
                        ]),
                      ],
                    ),
                  ],
                );
              }
              if (state is WeatherLoadedFailue) {
                return Center(
                  child: Text(state.message),
                );
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }
}

class DoctorPage extends StatelessWidget {
  const DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.all(1),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: Material(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      controller: _textController,
                      onChanged: (text) {
                        dataBloc.add(onDoctorsearchByName(doctorName: text));
                      },
                      decoration: InputDecoration(
                          hintText: "Doctor's name",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<DoctorBloc, DoctorState>(
                  builder: (context, state) {
                if (state is DoctorLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is ChossenDoctor) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("hello"),
                    ),
                  );
                }
                if (state is DoctorLoaded) {
                  final doctors = state.doctor;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Material(
                            child: ListView.builder(
                              itemCount: doctors.length,
                              itemBuilder: (context, index) {
                                final doctor = doctors[index];

                                // Customize the DoctorEntity widget as needed
                                return ListTile(
                                  // onTap: () {
                                  //   context
                                  //       .read<DoctorBloc>()
                                  //       .add(onDoctorChoose(doctor: doctor));
                                  // },
                                  title: Text(doctor.firstName),
                                  subtitle: Text(doctor.lastName),
                                  // Add more fields as needed
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (state is DoctorLoadingFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Container();
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctgorAuthPage extends StatelessWidget {
  const DoctgorAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          alignment: AlignmentDirectional.center,
          padding: EdgeInsets.all(1),
          color: Colors.white,
          child: BlocBuilder<DoctorAuthBloc, DoctorAuthState>(
              builder: (context, state) {
            if (state is DoctorAuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is DoctorAuthSuccessful) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("hello"),
                ),
              );
            }
            if (state is DoctorAuthInitial) {
              return LoginScreen(context);
            }
            if (state is DoctorAuthFailed) {
              return LoginScreen(context,
                  showSnackBar: true, message: state.error);
            }
            return Container();
          }),
        ));
  }
}

Widget LoginScreen(context, {showSnackBar = false, message = ''}) {
  final DoctorAuthBloc authBloc = BlocProvider.of<DoctorAuthBloc>(context);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  if (showSnackBar) {
    print("error");
  }
  return Scaffold(
    appBar: AppBar(
      title: Text('Login Page'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              final email = emailController.text;
              final password = passwordController.text;
              authBloc.add(onSignIn(email: email, password: password));
            },
            child: Text('Login'),
          ),
        ],
      ),
    ),
  );
}
