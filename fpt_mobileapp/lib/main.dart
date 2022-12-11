import 'package:flutter/material.dart';
import './TripField/TripScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './api/tripApi.dart';
import './TripField/bloc/trip_bloc.dart';
import './abc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TripFieldAPI>(create: (context) => TripFieldAPI())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TripBloc>(
            create: (BuildContext context) => TripBloc(api: TripFieldAPI())..add(LoadedTrip())
            ,child: HomeTripWidget(),
          )
        ],
        child: StrartApp(),
      ),
    );
  }
}

class StrartApp extends StatefulWidget {
  @override
  _StrartApp createState() => _StrartApp();
}

class _StrartApp extends State<StrartApp> {
  @override
  Widget build(BuildContext context) {
    final _navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: _navigatorKey,
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: const MyHomePage(),
      routes: {
        '/home': (BuildContext context) => const MyHomePage(),
        '/trip': (BuildContext context) => const HomeTripWidget(),
      },
    );
  }
}
