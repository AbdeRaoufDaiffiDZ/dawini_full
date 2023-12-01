import 'package:dawini_full/patient_features/presentation/pages/weather_pag.dart';
import 'package:dawini_full/splashes/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dawini_full/firebase_options.dart';
import 'package:dawini_full/injection_container.dart';
import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages_shower.dart';
import 'package:dawini_full/patient_features/presentation/bloc/auth_bloc/bloc/doctor_auth_bloc.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<DoctorAuthBloc>()),
          BlocProvider(
            create: (_) => locator<DoctorBloc>(),
          ),
          BlocProvider(
            create: (_) => locator<IntroductionBloc>(),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Splash(),
        ));
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  bool status = false;
  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  @override
  Widget build(BuildContext context) {
    Size device_size = MediaQuery.of(context).size;

    if (status) {
      return DoctorPage(
        device_size: device_size,
      );
    } else {
      return PagesShower(
        size: device_size,
      );
    }
  }

  Future<void> _loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      status = (prefs.getBool('ignore') ?? false);
    });
  }
}
