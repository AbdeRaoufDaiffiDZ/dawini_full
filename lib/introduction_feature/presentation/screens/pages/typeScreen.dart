import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeScreen extends StatefulWidget {
  final String type;
  final Size device_size;

  const TypeScreen({super.key, required this.type, required this.device_size});

  @override
  State<TypeScreen> createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  @override
  Widget build(BuildContext context) {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Who are you!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: widget.device_size.height * 0.2),
            MaterialButton(
              color: "patient" == widget.type ? Colors.green : Colors.grey,
              onPressed: () {
                // Add the action you want to perform when the button is pressed
                // For example, you can show a dialog or navigate to another screen.
                bloc.add(onTypeChoose(type: "patient"));
              },
              child: Text('Looking for a Doctor'),
            ), // Add spacing between text and button

            SizedBox(height: 20.0),
            MaterialButton(
              color: "doctor" == widget.type ? Colors.green : Colors.grey,
              onPressed: () {
                // Add the action you want to perform when the button is pressed
                // For example, you can show a dialog or navigate to another screen.
                bloc.add(onTypeChoose(type: "doctor"));
              },
              child: Text("I'm a Doctor"),
            ), // Add spacing between text and button
            SizedBox(height: 20.0),
            SizedBox(
              width: widget.device_size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  // Add the action you want to perform when the button is pressed
                  // For example, you can show a dialog or navigate to another screen.
                  bloc.add(NextPage(id: 3));
                },
                child: Text('next'),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Add the action you want to perform when the button is pressed
            //     // For example, you can show a dialog or navigate to another screen.
            //     bloc.add(NextPage(id: 3));
            //   },
            //   child: Text('Looking for a Doctor'),
            // ),
            // SizedBox(height: 20.0), // Add spacing between text and button
            // ElevatedButton(
            //   onPressed: () {
            //     // Add the action you want to perform when the button is pressed
            //     // For example, you can show a dialog or navigate to another screen.
            //     bloc.add(NextPage(id: 3));
            //   },
            //   child: Text("I'm a Doctor"),
            // )
          ],
        ),
      ),
    );
  }
}
