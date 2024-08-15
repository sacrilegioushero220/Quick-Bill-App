import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/Cubits/invoice_cubit/invoice_cubit.dart';
import 'package:quick_bill/Screens/splash_screen.dart';
import 'package:quick_bill/cubits/bloc_observer.dart';
import 'package:quick_bill/cubits/items_cubit/items_cubit.dart';
import 'package:quick_bill/cubits/storage_cubit/storage_cubit.dart';

void main() {
  Bloc.observer = CustomBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => InvoiceCubit(),
      ),
      BlocProvider(
        create: (context) => ItemCubit(),
      ),
      BlocProvider(
        create: (context) => StorageCubit(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
