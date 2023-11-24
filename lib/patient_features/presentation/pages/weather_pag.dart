// ignore_for_file: prefer_const_constructors

import 'package:dawini_full/patient_features/presentation/bloc/auth_bloc/bloc/doctor_auth_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorPage extends StatelessWidget {
  final Size device_size;
  DoctorPage({super.key, required this.device_size});

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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
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
                      title: Text("HERE"),
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
                                  onTap: () {
                                    context
                                        .read<DoctorBloc>()
                                        .add(onDoctorChoose(doctor: doctor));
                                  },
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
