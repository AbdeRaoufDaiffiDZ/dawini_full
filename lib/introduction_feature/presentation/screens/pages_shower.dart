import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages/languageScreen.dart';
import 'package:dawini_full/introduction_feature/presentation/screens/pages/typeScreen.dart';
import 'package:dawini_full/patient_features/presentation/pages/myApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagesShower extends StatefulWidget {
  final Size size;
  const PagesShower({super.key, required this.size});

  @override
  State<PagesShower> createState() => _PagesShowerState();
}

class _PagesShowerState extends State<PagesShower> {
  @override
  Widget build(BuildContext context) {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);

    return BlocBuilder<IntroductionBloc, IntroductionState>(
      builder: (context, state) {
        if (state is LanguageState) {
          return LanguageScreen(
            Language: state.language,
            device_size: widget.size,
          );
        } else if (state is TypeState) {
          return TypeScreen(
            type: state.type,
            device_size: widget.size,
          );
        } else if (state is LoadingState) {
          return const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.green,
          );
        } else if (state is IgnoreIntorductionState) {
          if (state.Screen == 'doctor') {
            return Mypage();
          } else {
            /////////////////////////////////////    here you will go to patients screen
            bloc.add(NextPage(id: 1));
            return Center();
          }
        } else {
          bloc.add(NextPage(id: 1));

          return Center();
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
