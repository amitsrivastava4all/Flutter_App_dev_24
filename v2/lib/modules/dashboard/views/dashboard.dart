import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_brainmentors/shared/services/gps.dart';
import 'package:todoapp_brainmentors/shared/widgets/textbox.dart';

import '../../user/cubit/user_cubit.dart';
import '../../user/cubit/user_state.dart';

class DashBoard extends StatelessWidget {
  TextEditingController taskNameCtrl = TextEditingController();
  TextEditingController taskDescCtrl = TextEditingController();

  _addToDb(String taskName, String taskDesc, String location) {
    print("Task Name $taskName Desc $taskDesc Location $location");
  }

  late String location;

  _getLocation() async {
    Position cord = await getGeoPosition();
    print("Cord ${cord.latitude} ${cord.longitude}");
    location = await getGPSLocation(cord.latitude, cord.longitude);
  }

  _showAddDialog(context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Enter Task Details'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextBox(
                      'Enter Task Name', 'Type Task Name Here', taskNameCtrl),
                  TextBox(
                      'Enter Task Desc', 'Type Task Desc Here', taskDescCtrl),
                  Text('Current Location '),
                  ElevatedButton(
                      onPressed: () {
                        _getLocation();
                      },
                      child: Text('Get Location'))
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _addToDb(taskNameCtrl.text, taskDescCtrl.text, location);
                  },
                  child: Text('Add Task'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.tealAccent,
          child: Text(
            '+',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            _showAddDialog(context);
          },
        ),
        body: SafeArea(
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.purpleAccent,
              Colors.tealAccent,
              Colors.redAccent
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<UserCubit, UserState>(
                  builder: (_, userState) {
                    return Column(
                      children: [
                        CircleAvatar(
                            backgroundImage: NetworkImage(userState
                                        .image.length ==
                                    0
                                ? 'https://cdn1.iconfinder.com/data/icons/user-pictures/100/male3-512.png'
                                : userState.image)),
                        Text(
                          userState.name.toUpperCase(),
                          style: GoogleFonts.pacifico(fontSize: 20),
                        ),
                        Text(
                          'Today ' +
                              DateFormat.yMMMMEEEEd().format(DateTime.now()),
                          style: GoogleFonts.aBeeZee(fontSize: 14),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 3,
                        )
                      ],
                    );
                  },
                ),
                // Outer Column
                SizedBox(
                  height: size.height * 0.10,
                ),
                Container(
                  height: size.height * 0.40,
                  width: size.width - size.width * 0.10,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 10,
                            blurRadius: 10),
                        BoxShadow(
                            color: Colors.orange,
                            spreadRadius: 5,
                            blurRadius: 5)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Tasks ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
