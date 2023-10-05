import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathers/screens/home_screen.dart';
import 'state_management/get_location/get_location_bloc.dart';
import 'state_management/get_weather/weather_bloc_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBlocBloc(),
        ),
        BlocProvider(
          create: (context) =>
              GetLocationBloc()..add(GetStartCurrentLocationEvent()),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
