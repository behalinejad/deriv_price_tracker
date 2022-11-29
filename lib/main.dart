import 'package:deriv_price_tracker/cubit/active_symbols_cubit.dart';
import 'package:deriv_price_tracker/cubit/ticks_cubit.dart';
import 'package:deriv_price_tracker/screens/price_tracker_page/price_tracker_page.dart';
import 'package:deriv_price_tracker/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider<ActiveSymbolsCubit>(
            create: (context)=>ActiveSymbolsCubit()
        ),
        BlocProvider<TicksCubit>(
            create: (context)=>TicksCubit()
        ),
         ],

    child: MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const PriceTrackerPage(),
    ),);
  }
}

