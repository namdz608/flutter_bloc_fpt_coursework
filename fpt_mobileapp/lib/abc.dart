import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpt_mobileapp/TripField/TripScreen.dart';
import './TripField/bloc/trip_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: IconButton(
          onPressed: () {
            BlocProvider.of<TripBloc>(context).add(LoadedTrip());
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   '/trip',
            //   (Route<dynamic> route) => false,
            // );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeTripWidget()),
            );
          },
          icon: Icon(Icons.volume_up),
        )));
  }
}
