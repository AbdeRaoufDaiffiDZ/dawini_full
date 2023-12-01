import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/bloc/doctor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMenu extends StatefulWidget {
  const SearchMenu({
    super.key,
  });
  @override
  State<SearchMenu> createState() => _SearchMenuState();
}

class _SearchMenuState extends State<SearchMenu> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);
    const List<String> list = <String>['all', 'bouira', 'Algiers', 'Tlemcen'];

    String dropdownValue = list.first;
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 50,
            width: 100,
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
                    // onChanged: (text) {
                    //   dataBloc.add(onDoctorsearchByName(
                    //       doctorName:
                    //           text)); ///////////////////////////////////: find doctor
                    // },
                    onChanged: (text) {
                      dataBloc.add(onDoctorsearchByName(doctorName: text));

                      ///
                    },
                    decoration: InputDecoration(
                        hintText: "doctor",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? wilaya) {
              // This is called when the user selects an item.

              dataBloc.add(onDoctorsearchByWilaya(
                  wilaya: wilaya.toString().toLowerCase()));
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
