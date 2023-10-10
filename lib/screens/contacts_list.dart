import 'package:contacts_watchlist/bloc/contact_bloc.dart';
import 'package:contacts_watchlist/widgets/contact_list_view.dart';
import 'package:contacts_watchlist/widgets/second_group.dart';
import 'package:contacts_watchlist/widgets/third_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(FetchContacts());
    BlocProvider.of<ContactBloc>(context).add(InitialSortingEvent());
  }

  // @override
  // void dispose() {
  //   super.dispose();

  //   // BlocProvider.of<ContactBloc>(context).close();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'Contacts List',
              style: TextStyle(color: Colors.black),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'Group 1',
              ),
              Tab(
                text: 'Group 2',
              ),
              Tab(
                text: 'Group 3',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
                height: double.infinity,
                padding: const EdgeInsets.only(top: 15.0),
                child: const ContactListView()),
            const SecondGroup(),
            const ThirdGroup(),
          ],
        ),
      ),
    );
  }
}
