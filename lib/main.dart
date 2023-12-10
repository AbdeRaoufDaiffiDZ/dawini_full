import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/presentation/bloc/clinics_bloc/bloc/clinics_bloc.dart';
import 'package:dawini_full/patient_features/presentation/pages/myApp.dart';
import 'package:dawini_full/splashes/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
          BlocProvider(
            create: (_) => locator<ClinicsBloc>()..add(ClinicinitialEvent()),
          ),
          BlocProvider(create: (_) => locator<DoctorAuthBloc>()),
          BlocProvider(
            create: (_) => locator<DoctorBloc>()..add(DoctorinitialEvent()),
          ),
          BlocProvider(
            create: (_) => locator<IntroductionBloc>(),
          )
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Splash(),
              );
            }));
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isConnected = false;

  bool status = false;
  @override
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        isConnected = hasInternet;
      });
      _showSnackBar(hasInternet);
    });
    _loadStatus();
  }

  void _showSnackBar(bool hasInternet) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text(hasInternet ? 'Internet Restored' : 'No Internet Connection'),
      backgroundColor: hasInternet ? Colors.green : Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (status) {
      if (status) {
        return Mypage();
      }
      return Scaffold(key: _scaffoldKey, body: Center(child: Loading()));
    } else {
      return PagesShower();
    }
  }

  Future<void> _loadStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      status = (prefs.getBool('ignore') ?? false);
    });
  }
}
