import 'package:contacts_watchlist/bloc/contact_bloc.dart';
import 'package:contacts_watchlist/screens/contacts_list.dart';
import 'package:contacts_watchlist/utils/services/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ContactBloc>(
      create: (context) => ContactBloc(ContactService()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ContactsList(),
    );
  }
}
