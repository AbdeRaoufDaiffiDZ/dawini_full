import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages/languageScreen.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages/typeScreen.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages/welcomeScreen.dart';
import 'package:dawini_full/patient_features/presentation/pages/weather_pag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagesShower extends StatefulWidget {
  const PagesShower({super.key});

  @override
  State<PagesShower> createState() => _PagesShowerState();
}

class _PagesShowerState extends State<PagesShower> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntroductionBloc, IntroductionState>(
      builder: (context, state) {
        if (state is LanguageState) {
          return LanguageScreen(Language: state.language);
        } else if (state is TypeState) {
          return const TypeScreen();
        } else if (state is LanguageState) {
          return const TypeScreen();
        } else if (state is LoadingState) {
          return const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.green,
          );
        } else if (state is IgnoreIntorductionState) {
          return const DoctorPage();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }

  Future<bool> chack() async {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);
    final status = await bloc.checkWatchingStatusUseCase.execute();
    return status;
  }
}
